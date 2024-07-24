// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// import { createClient } from 'npm:@supabase/supabase-js';
import { prepareVirtualFile } from 'https://deno.land/x/mock_file@v1.1.2/mod.ts';
import { PutObjectCommand, S3Client } from 'npm:@aws-sdk/client-s3';



Deno.serve(async (req: Request) => {
  prepareVirtualFile('./aws/config');
  prepareVirtualFile('./aws/credentials')

  if (req.method === 'POST') {
    const s3Client = new S3Client({});

    const cloudFrontDomain = Deno.env.get('CLOUDFRONT_DOMAIN');

    console.log(cloudFrontDomain);

    const formData = await req.formData();
    const file = formData.get('file') as File;

    if (file) {
      const fileContent = new Uint8Array(await file.arrayBuffer());

      const uploadParams = {
        Bucket: Deno.env.get("AWS_BUCKET"),
        Key: file.name,
        Body: fileContent,
      }

      const fileUrl = `${cloudFrontDomain}/${file.name}`;

      try {
        const command = new PutObjectCommand(uploadParams);
        await s3Client.send(command);
        return new Response(JSON.stringify({ message: 'File uploaded successfully ', fileUrl }), { status: 200 });
      } catch (err) {
        console.error(err);
        return new Response(JSON.stringify({ message: 'Error uploading file', error: err }), { status: 500 });
      }

      // return new Response(JSON.stringify({ message: 'Test' }), { status: 200 });
    } else {
      return new Response(JSON.stringify({ message: 'No file uploaded. File is required' }), { status: 400 });
    }
  }

  return new Response('Method Not Allowed', { status: 405 });
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/upload-to-s3' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
