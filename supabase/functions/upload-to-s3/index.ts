// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { corsHeaders } from '../_shared/cors.ts';
import { prepareVirtualFile } from 'https://deno.land/x/mock_file@v1.1.2/mod.ts';
import { PutObjectCommand, S3Client } from 'npm:@aws-sdk/client-s3';


Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { status: 204, headers: { ...corsHeaders } });
  }

  prepareVirtualFile('./aws/config');
  prepareVirtualFile('./aws/credentials')

  if (req.method === 'POST') {
    let s3Client = null;
    if (Deno.env.get('ENVIRONMENT') === "local") {
      s3Client = new S3Client({
        region: 'us-east-2',
        endpoint: Deno.env.get('LOCAL_AWS_DOMAIN'),
        forcePathStyle: true,
        credentials: {
          accessKeyId: 'test',
          secretAccessKey: 'test'
        }
      });
    } else {
      s3Client = new S3Client({});
    }

    const cloudFrontDomain = Deno.env.get('CLOUDFRONT_DOMAIN');

    const getDateForVersioning = () => {
      const currDate = new Date();

      const date = ("0" + currDate.getDate()).slice(-2);

      const month = ("0" + (currDate.getMonth() + 1)).slice(-2);

      const year = currDate.getFullYear();

      const hours = currDate.getHours();

      const seconds = currDate.getSeconds();

      return `_v${month}${date}${year}${hours}${seconds}`;
    }

    const slugify = (str: string) => (
      String(str)
        .normalize('NFKD') // split accented characters into their base characters and diacritical marks
        .replace(/[\u0300-\u036f]/g, '') // remove all the accents, which happen to be all in the \u03xx UNICODE block.
        .trim() // trim leading or trailing whitespace
        .toLowerCase() // convert to lowercase
        .replace(/[^a-z0-9 -]/g, '') // remove non-alphanumeric characters
        .replace(/\s+/g, '-') // replace spaces with hyphens
        .replace(/-+/g, '-') // remove consecutive hyphens
    )

    const objectKeyName = (objectKey: string) => {
      const pathParts = objectKey.split('/');
      const fullFileName = pathParts.pop();
      const dotIndex = fullFileName?.lastIndexOf('.');

      const fileName = dotIndex === -1 ? fullFileName : fullFileName?.substring(0, dotIndex);
      const extension = dotIndex === -1 ? '' : fullFileName?.substring(dotIndex as number);

      const slugifiedFileName = slugify(fileName as string);

      const newFilePath = [...pathParts, slugifiedFileName + getDateForVersioning() + extension].join('/');
      return newFilePath;
    }

    const removeLeadingSlash = (str: string) => {
      if (str.startsWith('/')) {
        return str.substring(1);
      }
      return str;
    }

    const getContentTypeFromExtension = (filename: string): string => {
      const extension = filename.split('.')?.[1] || null;
      if (!extension) {
        return 'application/octet-stream';
      }

      switch(extension) {
        case 'tiff':
        case 'tif':
          return 'image/tiff';
        case 'jpg':
        case 'jpeg':
          return 'image/jpeg';
        case 'png':
          return 'image/png';
        case 'webp':
          return 'image/webp';
        case 'avif':
          return 'image/avif';
        case 'txt':
          return 'text/plain';
        case 'svg':
          return  'image/svg+xml';
        case 'pdf':
          return 'application/pdf';
        case 'docx':
          return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        case 'xlsx':
          return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        case 'csv':
          return 'text/csv';
        case 'epub':
          return 'application/epub+zip';
        default:
          return 'application/octet-stream';
      }
    }

    const formData = await req.formData();
    const file = formData.get('file') as File;
    const prependPath = formData.get('path') as File;

    if (file) {
      const fileContent = new Uint8Array(await file.arrayBuffer());

      let fileName = file.name;

      if (prependPath) fileName = `${prependPath}${fileName}`;
      const objectKeyPath = removeLeadingSlash(objectKeyName(fileName));

      const uploadParams = {
        Bucket: Deno.env.get("AWS_BUCKET"),
        Key: objectKeyPath,
        Body: fileContent,
        ContentType: getContentTypeFromExtension(file.name),
        // ContentDisposition: `inline; filename="${file.name}"; filename*=UTF-8''${encodeURIComponent(file.name).toString()}`,
      }

      const fileUrl = `${cloudFrontDomain}${objectKeyPath}`.replace(/([^:]\/)\/+/g, "$1");

      try {
        const createCommand = new PutObjectCommand(uploadParams);
        await s3Client.send(createCommand);
        return new Response(JSON.stringify({ message: 'File uploaded successfully ', fileUrl }), { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
      } catch (err) {
        console.error(err);
        return new Response(JSON.stringify({ message: 'Error uploading file', error: err }), { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
      }

      // return new Response(JSON.stringify({ message: 'Test' }), { status: 200 });
    } else {
      return new Response(JSON.stringify({ message: 'No file uploaded. File is required' }), { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
    }
  }

  return new Response(JSON.stringify({ message: 'Method Not Allowed'}), { status: 405, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/upload-to-s3' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
