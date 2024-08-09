// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { corsHeaders } from '../_shared/cors.ts';
import { prepareVirtualFile } from 'https://deno.land/x/mock_file@v1.1.2/mod.ts';
import { DeleteObjectCommand, S3Client } from 'npm:@aws-sdk/client-s3';
import { CloudFrontClient, CreateInvalidationCommand } from 'npm:@aws-sdk/client-cloudfront';

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: { ...corsHeaders } });
  }

  prepareVirtualFile('./aws/config');
  prepareVirtualFile('./aws/credentials');

  if (req.method === 'DELETE') {
    const s3Client = new S3Client({});
    const cloudFrontClient = new CloudFrontClient({});

    const cloudFrontDomain = Deno.env.get('CLOUDFRONT_DOMAIN');

    const body = await req.json();

    const previousImage = body?.prevImageUrl;

    if (previousImage) {
      const previousKey = previousImage.replace(cloudFrontDomain as string, "").replace(/\s+/g, '');

      console.info(previousKey);

      const deleteParams = {
        Bucket: Deno.env.get('AWS_BUCKET'),
        Key: previousKey,
      }

      const invalidationParams = {
        DistributionId: Deno.env.get('DISTRIBUTION_ID'),
        InvalidationBatch: {
          CallerReference: previousKey,
          Paths: {
            Quantity: 1,
            Items: [
              '/' + previousKey
            ]
          }
        }
      }

      try {
        const deleteCommand = new DeleteObjectCommand(deleteParams);
        await s3Client.send(deleteCommand);

        try {
          const invalidationCommand = new CreateInvalidationCommand(invalidationParams);
          await cloudFrontClient.send(invalidationCommand);

          return new Response(JSON.stringify({ message: 'Previous file deleted successfully' }), { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
        } catch (err) {
          console.error(err);
        }

      } catch (e) {
        console.error(e);
        return new Response(JSON.stringify({ message: 'Error deleting old file', error: e }), { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
      }  
    } else {
      return new Response(JSON.stringify({ message: 'Previous Image Url is required' }), { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
    }
  }

  return new Response(JSON.stringify({ message: 'Method Not Allowed'}), { status: 405, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/delete-from-s3' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
