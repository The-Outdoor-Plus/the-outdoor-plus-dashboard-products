SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.5 (Ubuntu 15.5-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', '96fccb42-276a-4f7e-bef1-113463433b54', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"rodrigo@theoutdoorplus.com","user_id":"475d57b8-9842-4a37-be05-2a5527efac99","user_phone":""}}', '2023-08-21 18:29:33.657895+00', ''),
	('00000000-0000-0000-0000-000000000000', '79463118-a893-4483-8c24-ecd65fc0d421', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-08-21 18:33:19.308502+00', ''),
	('00000000-0000-0000-0000-000000000000', '45af63c7-33fa-45fe-bd6f-94005bd90a64', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-08-21 19:47:52.015134+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f649da4a-4250-438c-9414-d1692c580dbd', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-08-21 19:47:52.015783+00', ''),
	('00000000-0000-0000-0000-000000000000', '33488f7b-180e-42fa-8951-f28550a7e387', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-08-21 20:07:14.926831+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c292d266-788e-4abc-892c-e1cfe9c70b7e', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-09-12 23:42:19.295291+00', ''),
	('00000000-0000-0000-0000-000000000000', '649c7251-7442-441c-8a09-4cd1ccbe727e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 15:26:10.228328+00', ''),
	('00000000-0000-0000-0000-000000000000', '924df59b-e84e-47a4-a631-802104d5cc79', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 15:26:10.228897+00', ''),
	('00000000-0000-0000-0000-000000000000', '75a6c0cc-5a05-4b78-904e-abaef4ceefdd', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-09-13 15:26:10.538526+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc4cd248-a6ec-4e20-a7a4-20508e836a9f', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-09-13 15:26:23.169741+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bf490ce6-1499-4233-beee-e1919bc1628a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 16:24:32.933311+00', ''),
	('00000000-0000-0000-0000-000000000000', '0491e37b-271a-4756-a17a-882528b3d98b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 16:24:32.934485+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a0e4d830-626c-4091-8e28-2d8c6916a418', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 17:22:42.783127+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e9414f69-f399-4852-b184-c1106fc95c86', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 17:22:42.784143+00', ''),
	('00000000-0000-0000-0000-000000000000', '49396204-f93e-4ee8-8747-41cb1b4d20e5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 18:22:01.708174+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d53e8aa-001a-4e73-b24b-064e727ef630', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 18:22:01.708774+00', ''),
	('00000000-0000-0000-0000-000000000000', '5cb27119-7169-4bee-8ff3-421f533a5dbd', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 19:59:20.508074+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ac3b4328-0181-4e15-8a73-f71ab39f0cf9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 19:59:20.509182+00', ''),
	('00000000-0000-0000-0000-000000000000', '8054739b-13ee-4b90-8914-2180b8cae678', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 20:57:46.507757+00', ''),
	('00000000-0000-0000-0000-000000000000', '4e57b5ba-5eb6-4383-bdc1-cc600f7055fc', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 20:57:46.508323+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f9c6279f-f244-4af7-b541-90d4c624750f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 21:55:53.072091+00', ''),
	('00000000-0000-0000-0000-000000000000', '2775d8bc-3454-482f-a371-e7051c029937', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 21:55:53.074087+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f7a1dc05-2147-4ebb-b21e-44bf6291bb0e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 22:54:12.866655+00', ''),
	('00000000-0000-0000-0000-000000000000', '73dc3f27-b361-408a-b871-4087c141758e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-13 22:54:12.867282+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e9fd0f63-664f-4a20-83d2-8ae663b6db8b', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-09-14 19:46:05.071356+00', ''),
	('00000000-0000-0000-0000-000000000000', '6bd287e6-6f2d-4fb2-93ba-86ef90d03868', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-14 20:46:15.74785+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eff2806f-1174-4dae-a4c3-3f3ed284dff1', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-14 20:46:15.748928+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b1d1de9f-f589-4455-8515-381e5d864866', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-09-14 20:46:16.059028+00', ''),
	('00000000-0000-0000-0000-000000000000', '5ddc8619-3b97-4485-9d9e-24b56e4c32cb', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-09-14 20:48:14.978648+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a6ce5e74-47cf-4f05-8d20-34cb8319ff23', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-14 21:46:35.843317+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a16ab007-f21a-48e8-b40b-b97c6ed97fa9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-14 21:46:35.844322+00', ''),
	('00000000-0000-0000-0000-000000000000', '63d28b39-c58d-4c55-9ad5-abad404052f7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-14 22:59:11.555593+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b210ab9b-483b-4903-9b4d-7e14abe89823', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-14 22:59:11.556159+00', ''),
	('00000000-0000-0000-0000-000000000000', '479c1fae-9216-49ad-ab05-06575cd4d18e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 15:20:55.625544+00', ''),
	('00000000-0000-0000-0000-000000000000', '5a925571-c6ce-49e1-b875-fdb67d086ba5', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 15:20:55.626139+00', ''),
	('00000000-0000-0000-0000-000000000000', '4b9da7d0-183b-48c6-a7cb-f6bafb675ed0', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 16:24:39.557386+00', ''),
	('00000000-0000-0000-0000-000000000000', '66fe12dc-14d2-4412-8517-6408cdf6a458', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 16:24:39.557967+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fd902982-d1d8-41f9-9474-6b230b424b4c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 17:25:23.393805+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bbb15c42-3d23-47b8-b6ee-9b11f0e9a2ac', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 17:25:23.394383+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd8f433c6-e448-466c-8dd0-75afefad4fc7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 18:27:41.045829+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bac804a7-be18-4a72-91c8-ff1771a922eb', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 18:27:41.046448+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dbabb0d5-3562-4fef-8e75-7c6907067f56', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 19:37:44.681223+00', ''),
	('00000000-0000-0000-0000-000000000000', '33ed6120-1b09-4e97-808b-6f5c6ec3a4c5', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-15 19:37:44.682542+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c42fdf97-8d1c-47a2-9c65-3b11b7703dec', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-18 15:05:21.694119+00', ''),
	('00000000-0000-0000-0000-000000000000', '4cfdb485-5205-4a4f-9b16-a38de13d2e6f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-18 15:05:21.695696+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd135d953-aa33-4567-bda4-d30fa60f9d5a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-18 21:31:56.587472+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b8a054b-b531-4868-b712-fdc3531fc639', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-18 21:31:56.588595+00', ''),
	('00000000-0000-0000-0000-000000000000', '1efa3da9-f28a-4302-9ca3-8d2de217c6f0', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-18 22:31:38.755482+00', ''),
	('00000000-0000-0000-0000-000000000000', '1465cafd-fd83-40ed-a77d-6ded4bd2dc8a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-09-18 22:31:38.756595+00', ''),
	('00000000-0000-0000-0000-000000000000', '40b9fb50-5a6f-4bdd-ad44-eac6cc5765ef', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-03 17:43:45.250549+00', ''),
	('00000000-0000-0000-0000-000000000000', '7260243b-730d-4a47-8c75-43fb4e04782a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-03 20:43:31.650285+00', ''),
	('00000000-0000-0000-0000-000000000000', '89b74ad0-3661-47b8-9d28-079d188215b3', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-03 20:43:31.652167+00', ''),
	('00000000-0000-0000-0000-000000000000', '1c9fe13b-8d2f-4337-8b0a-9c81a1133763', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-04 23:35:43.896581+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fc24b884-36da-4d1d-8f82-6ab92beca097', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-04 23:35:43.911202+00', ''),
	('00000000-0000-0000-0000-000000000000', '4ad829f3-030a-4108-ac37-0a1345f388a8', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-10-04 23:35:44.325997+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f87c96e9-29d0-4d9b-87be-4865228684ce', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-04 23:35:47.366198+00', ''),
	('00000000-0000-0000-0000-000000000000', '902fec53-c2f7-447f-a70b-6f2726724042', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 15:07:42.021727+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a84ff51-b392-4268-ae61-b211f6431c0d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 15:07:42.023041+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a6e35925-b866-4653-acb5-c9e66925e50b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 16:05:46.812596+00', ''),
	('00000000-0000-0000-0000-000000000000', '019fbb0d-e50b-428a-b013-97c7dfad4e0e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 16:05:46.813196+00', ''),
	('00000000-0000-0000-0000-000000000000', '9f517547-a66c-4bac-908a-9a19a4faf0b8', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 17:04:07.203442+00', ''),
	('00000000-0000-0000-0000-000000000000', '2c209714-6348-475d-ab38-30970cba9668', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 17:04:07.204032+00', ''),
	('00000000-0000-0000-0000-000000000000', '8231fff0-c36c-44f8-b4e4-75cd21ab9e4d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 20:19:59.827076+00', ''),
	('00000000-0000-0000-0000-000000000000', '6a2c1212-1f8a-494f-82dc-ad3e90437e53', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 20:19:59.828292+00', ''),
	('00000000-0000-0000-0000-000000000000', '2db9aec9-bb78-43ba-b7c4-e4985a945c31', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 21:33:56.148215+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b53c053b-fd1a-4c73-a5ec-8dccfc1ab37e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 21:33:56.149544+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f846dfed-db08-4f40-a5ba-77c7229380cf', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 22:32:12.454439+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f98fecb7-456d-411d-8e7a-3775e859901e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-05 22:32:12.45501+00', ''),
	('00000000-0000-0000-0000-000000000000', '02dd0828-73d9-48e7-9d45-ce0418029126', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 16:05:07.901593+00', ''),
	('00000000-0000-0000-0000-000000000000', '346abc17-e830-4483-a0ec-c49d95908078', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 16:05:07.906199+00', ''),
	('00000000-0000-0000-0000-000000000000', '3971e960-5305-449c-90b8-86bbb71dbcf1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 17:05:01.589528+00', ''),
	('00000000-0000-0000-0000-000000000000', '14d4ce40-51fb-44ef-9423-c13c9f012383', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 17:05:01.591305+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b186727-f9e4-40db-8ac3-a19d90eb73f5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 18:29:56.781545+00', ''),
	('00000000-0000-0000-0000-000000000000', '362d4ad1-c40f-4e03-b321-d38cafe4201f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 18:29:56.78338+00', ''),
	('00000000-0000-0000-0000-000000000000', '5587c881-7d1e-4458-a02c-de8c1fd6b8b2', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 19:50:47.971967+00', ''),
	('00000000-0000-0000-0000-000000000000', '9cb3ed00-da0a-4b2a-ba4a-ea055d2e2387', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 19:50:47.973844+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ccc236a1-b66f-4063-9bc1-16811a075308', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 20:48:55.043236+00', ''),
	('00000000-0000-0000-0000-000000000000', '65edcece-0015-44d2-998c-4cc08090897a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 20:48:55.043832+00', ''),
	('00000000-0000-0000-0000-000000000000', 'aa0c1c83-ce04-4034-8267-becbba55a436', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"dealer@topdashboard.com","user_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","user_phone":""}}', '2023-10-09 21:37:08.186088+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e9441ade-904d-4185-96c8-efde3da6ec53', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"group@topdashboard.com","user_id":"3bc9b49e-448d-45e1-8316-76bc063948db","user_phone":""}}', '2023-10-09 21:37:30.434936+00', ''),
	('00000000-0000-0000-0000-000000000000', '133f31e0-92c4-4c90-8496-609d11d51ef4', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-10-09 21:38:13.098173+00', ''),
	('00000000-0000-0000-0000-000000000000', '829c64bc-4ed1-422d-92de-6515b3a9cc33', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 21:38:29.533272+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e8388fe6-d367-4722-858f-c77e9e002354', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"landscape@topdashboard.com","user_id":"f61ccb8b-5809-4d54-b979-7e39b0398982","user_phone":""}}', '2023-10-09 21:39:43.397006+00', ''),
	('00000000-0000-0000-0000-000000000000', '5ff76c18-d64f-4daf-ac30-543ed5a9be28', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"internet@topdashboard.com","user_id":"1a494fcc-4e7c-4541-84f1-70f0a77223bc","user_phone":""}}', '2023-10-09 21:40:03.228041+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e9af3b6-b805-496a-ae0c-82100f1c4dfa', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"master@topdashboard.com","user_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","user_phone":""}}', '2023-10-09 21:40:28.729405+00', ''),
	('00000000-0000-0000-0000-000000000000', '8fa87b05-fe27-47b1-8244-b9cdf874328b', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"distributor@topdashboard.com","user_id":"40db71eb-68d2-402a-ae3f-6bd099418409","user_phone":""}}', '2023-10-09 21:40:57.440799+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ed994ef6-2762-46f2-8a25-fb1a6e6f237b', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ecommerce@topdashboard.com","user_id":"f186c7f3-a0dd-4754-b60c-ed6d8f2a3ded","user_phone":""}}', '2023-10-09 21:41:31.525613+00', ''),
	('00000000-0000-0000-0000-000000000000', '6ae07f52-c3d3-402d-b30a-e5ef2df0bbb2', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"guest@topdashboard.com","user_id":"53191866-daae-404c-807b-1ee85190eebb","user_phone":""}}', '2023-10-09 21:41:47.11998+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b68bce81-ec92-43e1-9f93-2da542a97a85', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2023-10-09 21:47:33.995008+00', ''),
	('00000000-0000-0000-0000-000000000000', '33425d79-8a5c-405c-ab73-1dc9c7920a17', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 21:47:39.718882+00', ''),
	('00000000-0000-0000-0000-000000000000', '43552c90-1938-4e5d-992a-0ea28e896593', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 21:47:43.929607+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cfabc0ef-e825-4368-87b3-ee31ed69488d', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 21:49:17.776318+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd9d7eb15-4cb0-4d32-b966-47c1aa077f57', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jesus@theoutdoorplus.com","user_id":"67b8a91a-f30f-4bde-90a1-7a632e250809","user_phone":""}}', '2023-10-09 22:19:02.712687+00', ''),
	('00000000-0000-0000-0000-000000000000', 'db12c5eb-ae67-42da-ae24-4d874463c76c', '{"action":"login","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 22:23:17.454723+00', ''),
	('00000000-0000-0000-0000-000000000000', '61220318-ee42-4b2b-b197-1f9a91b74134', '{"action":"logout","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2023-10-09 22:26:20.776488+00', ''),
	('00000000-0000-0000-0000-000000000000', '1baf37c1-5150-4727-b868-f9557bf1233d', '{"action":"login","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 22:26:44.713944+00', ''),
	('00000000-0000-0000-0000-000000000000', '4cc60c56-c7db-4234-859b-ad64bbbed837', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2023-10-09 22:28:08.902885+00', ''),
	('00000000-0000-0000-0000-000000000000', '5c674073-eb06-4a60-8606-9fcac981d48c', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 22:28:13.824952+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc709087-1144-4a36-bf03-a1a9830d0bc9', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2023-10-09 22:28:15.115876+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f6c62348-b68b-45d9-9b5c-1ab109dc32e6', '{"action":"login","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 22:28:47.991819+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e80224eb-9864-410b-ad2e-9d7986aad5e3', '{"action":"login","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 22:29:58.441428+00', ''),
	('00000000-0000-0000-0000-000000000000', '389881bd-7641-4801-b75b-c77a386d0790', '{"action":"login","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-09 22:34:40.47716+00', ''),
	('00000000-0000-0000-0000-000000000000', '32baebc4-153b-4f2d-86d4-d7569b34f6d1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 23:15:06.649684+00', ''),
	('00000000-0000-0000-0000-000000000000', '5fad443e-7d8a-4559-af23-c663d9d46ccf', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-09 23:15:06.65169+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f43bc2b7-6eef-42ce-9bba-665d53da4c99', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 15:04:00.244688+00', ''),
	('00000000-0000-0000-0000-000000000000', '86bc7fa2-ba9c-4f67-b42c-de6f08b2aff3', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 15:04:00.246518+00', ''),
	('00000000-0000-0000-0000-000000000000', '8058261a-ec84-45b1-b56c-0fdcffbaa926', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 15:32:29.374658+00', ''),
	('00000000-0000-0000-0000-000000000000', '80f2770d-2aad-4913-b413-57c7e0186a08', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 15:32:29.375886+00', ''),
	('00000000-0000-0000-0000-000000000000', '90f6a946-8738-46c9-9285-bb8ebd08dea5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 16:04:32.282796+00', ''),
	('00000000-0000-0000-0000-000000000000', '6603a6d5-390e-45aa-bb08-9dd06035c7c1', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 16:04:32.285365+00', ''),
	('00000000-0000-0000-0000-000000000000', '6596e1d2-e22c-43da-9d44-a970cdab5fcb', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 17:03:09.902835+00', ''),
	('00000000-0000-0000-0000-000000000000', '5933d3f3-6be0-4399-b2af-ab191be45480', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 17:03:09.906573+00', ''),
	('00000000-0000-0000-0000-000000000000', '10db0d7e-56ae-4313-9d74-997671cf4ca4', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 17:03:15.529405+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a1291b10-444f-4269-a21e-df49b1a7b1fc', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 17:03:15.52998+00', ''),
	('00000000-0000-0000-0000-000000000000', '7a23f55e-1a21-4f4a-a763-924b143f0a7b', '{"action":"login","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-10 17:06:12.341632+00', ''),
	('00000000-0000-0000-0000-000000000000', '905efeb1-0bd5-4d90-90e2-883116e70695', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 17:38:24.031914+00', ''),
	('00000000-0000-0000-0000-000000000000', '8e34b6e7-7e10-4d03-b8a9-ed71784f838b', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 17:38:24.035127+00', ''),
	('00000000-0000-0000-0000-000000000000', '3476aa59-f20f-4a65-844d-86c4dac32e26', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 18:02:41.156615+00', ''),
	('00000000-0000-0000-0000-000000000000', '122c5eff-567a-4d7a-9e60-3c6f90cacee9', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 18:02:41.15864+00', ''),
	('00000000-0000-0000-0000-000000000000', '2f665851-304d-427b-a749-005b5fe7d2d1', '{"action":"token_refreshed","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 18:06:03.732641+00', ''),
	('00000000-0000-0000-0000-000000000000', '37060dd1-4afb-4f6b-af4d-2919e29369e5', '{"action":"token_revoked","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 18:06:03.73494+00', ''),
	('00000000-0000-0000-0000-000000000000', 'abcaec57-d2a1-492e-bb4c-2830cf49512f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 18:07:36.399895+00', ''),
	('00000000-0000-0000-0000-000000000000', '440c4eed-a249-4def-910c-d82af68c6491', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 18:07:36.400454+00', ''),
	('00000000-0000-0000-0000-000000000000', '11284bca-02ff-4ec8-8db7-aa7830763767', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 22:59:36.323926+00', ''),
	('00000000-0000-0000-0000-000000000000', '8cb1c599-a0c9-490b-b05b-df0f03ea3311', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 22:59:36.326829+00', ''),
	('00000000-0000-0000-0000-000000000000', '90acb566-e5ad-4a83-bf1e-72cd27f1491c', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-10-10 22:59:36.55315+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd8fd4afe-2d93-4d2f-b4a1-616ebba79844', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 23:29:30.34986+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ce9e3556-d0c0-4e44-9092-52ce5065bdc1', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-10 23:29:30.351617+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd60f0cad-16af-4bda-a49d-16c871207921', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 15:23:56.784879+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e6e21620-bb38-4b56-b2d0-24107cab5710', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 15:23:56.787016+00', ''),
	('00000000-0000-0000-0000-000000000000', '8547fa9e-0d82-4cd2-a7c8-d58722e507c4', '{"action":"login","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-11 15:58:28.62693+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c5963461-0604-4afa-85aa-697124e5083e', '{"action":"token_refreshed","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 17:43:23.431567+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e32a89e8-204c-4df6-b540-2dcb51c5cfb3', '{"action":"token_revoked","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 17:43:23.433999+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c99be453-3e4f-45f9-a9dc-80500a56cb4f', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 19:12:38.543593+00', ''),
	('00000000-0000-0000-0000-000000000000', '34f45c29-1f99-463a-82b1-856f875027b5', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 19:12:38.546289+00', ''),
	('00000000-0000-0000-0000-000000000000', 'de2a5c71-4635-4bd6-a86a-48b3e84ad1b4', '{"action":"logout","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2023-10-11 19:12:38.921741+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd2a2d48b-39e0-4efb-9917-0e4d6a51c08a', '{"action":"login","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-11 19:12:43.816328+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ec4da280-db52-4778-a347-2f2432bc14ee', '{"action":"token_refreshed","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 19:23:17.900252+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b990b73-393d-4c56-852a-945f90d08be7', '{"action":"token_revoked","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-11 19:23:17.902066+00', ''),
	('00000000-0000-0000-0000-000000000000', '65ac0bb2-6097-4ed8-808e-8ee699acb85e', '{"action":"logout","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2023-10-11 19:25:33.607394+00', ''),
	('00000000-0000-0000-0000-000000000000', '2c0f9278-1ad8-4452-934b-bbda3e8719ff', '{"action":"login","actor_id":"f059f4c0-d479-467e-844d-0ba3d7c3a270","actor_username":"master@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-11 19:25:43.770296+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a9397f8d-64fc-4522-8a69-9a1a9240b73a', '{"action":"token_refreshed","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-13 15:12:14.205761+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d4c56c2-6020-4bf9-904f-b5880f603577', '{"action":"token_revoked","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2023-10-13 15:12:14.21429+00', ''),
	('00000000-0000-0000-0000-000000000000', '82f905f9-4eb0-4940-8d08-7bb67bb3c930', '{"action":"logout","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2023-10-13 15:12:14.785903+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f050a671-e281-4277-b80d-f290f4f5bedf', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-13 15:32:30.499939+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5bb5428-0e4f-434e-a885-c6d3acb0d5cd', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-17 15:59:46.787973+00', ''),
	('00000000-0000-0000-0000-000000000000', '9b2ed8cf-2471-4379-ae28-18ca261bf32a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-17 15:59:46.804952+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cd58062d-0d64-4486-86d9-c34ed16419bf', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-10-17 15:59:47.064444+00', ''),
	('00000000-0000-0000-0000-000000000000', '0b762349-7f62-4ac6-968e-22ddd8415a94', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-10-17 15:59:49.13145+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ec47d3ff-c408-4a93-802a-6c55dd1bbc5a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-17 17:23:14.328892+00', ''),
	('00000000-0000-0000-0000-000000000000', '6546ff8f-210c-49e2-88f8-b07524ef4273', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-10-17 17:23:14.331701+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd52d2288-92bf-4080-9d92-1812a0ec7a81', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-10-17 17:23:14.580531+00', ''),
	('00000000-0000-0000-0000-000000000000', '41ed35aa-0651-4af9-b908-6a43f46c9e69', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-12-07 00:15:27.727882+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c63f7f5e-7628-4d8a-8388-79550c224bb6', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 19:07:16.955889+00', ''),
	('00000000-0000-0000-0000-000000000000', '9ca968c0-3043-432c-8f1b-938df6000315', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 19:07:16.956481+00', ''),
	('00000000-0000-0000-0000-000000000000', '7f5fdf21-400f-4754-80c6-e57d36e94a74', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-12-07 19:07:17.09549+00', ''),
	('00000000-0000-0000-0000-000000000000', '29b2f79c-e20c-45cf-b181-12ea05266698', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-12-07 19:07:28.596657+00', ''),
	('00000000-0000-0000-0000-000000000000', '2b73e221-e175-4763-b014-97c4b7efdcbe', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 20:05:53.630739+00', ''),
	('00000000-0000-0000-0000-000000000000', '4982260c-d19b-4aa2-8675-b53260d9e6e8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 20:05:53.631419+00', ''),
	('00000000-0000-0000-0000-000000000000', '0287faf6-5418-44a7-aaaa-62d980e8f591', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 21:04:35.645602+00', ''),
	('00000000-0000-0000-0000-000000000000', '8420c40f-773d-472b-8200-a10eee08245e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 21:04:35.646202+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b4e01c88-eea9-4c36-bcb3-64f2c1575a81', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 22:07:28.459331+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5db2d69-9a6a-4313-949a-f34530e1be68', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 22:07:28.459922+00', ''),
	('00000000-0000-0000-0000-000000000000', '345a2113-a8b5-4a29-942b-79404a8cfb54', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 23:09:08.492631+00', ''),
	('00000000-0000-0000-0000-000000000000', '0b6c7172-e41e-4106-848f-1e40d446a8da', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-07 23:09:08.493242+00', ''),
	('00000000-0000-0000-0000-000000000000', '3373956d-eec4-4208-9826-7a41a01f2707', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 00:20:37.228004+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c5384c5f-5e14-4f64-815f-817213a4c43b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 00:20:37.228576+00', ''),
	('00000000-0000-0000-0000-000000000000', '38ee11fb-27ad-4259-9d92-8ded11ac68bb', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 16:27:37.382783+00', ''),
	('00000000-0000-0000-0000-000000000000', '648a91e8-8b3b-4bf3-89a6-ac623b17ea39', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 16:27:37.383353+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cddc2bc7-583b-47e9-b06b-6594233d14c5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 19:09:26.854909+00', ''),
	('00000000-0000-0000-0000-000000000000', '1985f245-6638-4347-aa83-0e5fcc5b5796', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 19:09:26.855502+00', ''),
	('00000000-0000-0000-0000-000000000000', '156640e0-8679-482d-875d-cb0b150dcdd3', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-12-08 19:09:26.988301+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b152db87-67a8-4d95-be4f-99fd3037ca19', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-12-08 19:10:48.277118+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a0a71436-b814-439d-b3da-234bc122013f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 20:49:09.269964+00', ''),
	('00000000-0000-0000-0000-000000000000', '02fcb614-d21d-42e5-968e-706ee778df92', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 20:49:09.270539+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a5534086-6a37-4f00-927f-522b33562070', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 21:47:24.702468+00', ''),
	('00000000-0000-0000-0000-000000000000', '3a1d486a-3b06-473e-8b54-876f7faf30ca', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 21:47:24.703081+00', ''),
	('00000000-0000-0000-0000-000000000000', '70219ac3-a4f4-45e4-bf5a-5a514fcca884', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 22:49:46.349593+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc0e3fc1-1dd2-4f20-b60a-4e92170175e7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 22:49:46.35018+00', ''),
	('00000000-0000-0000-0000-000000000000', '92a425a2-8ee4-43e0-9bc6-b9700b82be30', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 23:51:13.931964+00', ''),
	('00000000-0000-0000-0000-000000000000', '1aadb8b4-f453-41ab-be87-1704f8d36d61', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-08 23:51:13.932535+00', ''),
	('00000000-0000-0000-0000-000000000000', '620ed610-097a-45c1-be44-622780ad7611', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 16:15:20.809696+00', ''),
	('00000000-0000-0000-0000-000000000000', '7696a932-6f6e-41ab-9ce8-9f91b3520a26', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 16:15:20.810304+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ef4fecd6-459b-41e5-8dbf-9007da90a42e', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-12-11 16:15:20.940136+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cdfdebcb-5ebd-4c29-8046-7767f6f09e9b', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-12-11 16:15:23.883217+00', ''),
	('00000000-0000-0000-0000-000000000000', '138c9b35-2f75-4ba1-96fe-c3b87736ee1b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 17:29:23.808565+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fd71398f-a27b-485f-99ed-d04588548b0c', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 17:29:23.809187+00', ''),
	('00000000-0000-0000-0000-000000000000', '809069ed-c647-41a8-9f99-1eb9a9635915', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-12-11 17:29:23.923204+00', ''),
	('00000000-0000-0000-0000-000000000000', '20350fd8-e036-483a-a43b-848d48bdcd6a', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-12-11 17:29:32.467294+00', ''),
	('00000000-0000-0000-0000-000000000000', '08e75308-b061-49b5-a936-bb30a8b4e49f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 18:44:16.04116+00', ''),
	('00000000-0000-0000-0000-000000000000', '42fd2ff9-1c5e-4029-a0d3-9fd718eb3d36', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 18:44:16.041895+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd9581671-f2c4-48c1-84f0-46ca5e238bc1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 20:04:01.630273+00', ''),
	('00000000-0000-0000-0000-000000000000', '698c3328-b42f-4519-a947-53568253d098', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 20:04:01.630823+00', ''),
	('00000000-0000-0000-0000-000000000000', '1473bd9f-99a8-45aa-9f4a-3eb462740b31', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 21:19:22.835565+00', ''),
	('00000000-0000-0000-0000-000000000000', '6d5e6159-c5ac-497f-9378-57a477537963', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 21:19:22.836142+00', ''),
	('00000000-0000-0000-0000-000000000000', '6151c966-600a-4232-8989-5074e0b64957', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 22:18:49.661278+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ed703d3a-4a85-4198-ba99-78b2134139ea', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 22:18:49.661843+00', ''),
	('00000000-0000-0000-0000-000000000000', '88765fa5-299a-4ab3-ab24-3598eff992bb', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 23:17:16.926769+00', ''),
	('00000000-0000-0000-0000-000000000000', '4568b8ce-7565-482f-806a-8de23290242f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-11 23:17:16.927371+00', ''),
	('00000000-0000-0000-0000-000000000000', '74e90143-ea7f-4b89-a965-0380ccfbd932', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 00:17:24.893467+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cf7bc1cd-93f2-4eb9-9b9d-9d93231f4be2', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 00:17:24.894086+00', ''),
	('00000000-0000-0000-0000-000000000000', '6661c0e5-754c-42b5-a1ca-0ed5307be98b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 16:13:02.072394+00', ''),
	('00000000-0000-0000-0000-000000000000', '2e4553b0-9f6d-45e0-b92e-683c30374609', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 16:13:02.073259+00', ''),
	('00000000-0000-0000-0000-000000000000', '3ce4ab88-173c-444b-b4f2-8d6d890aca8a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 17:19:10.454737+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eb622a02-29d5-4e23-b87a-6d67e0eedb16', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 17:19:10.455369+00', ''),
	('00000000-0000-0000-0000-000000000000', '0ad886a5-2d55-48c3-b8b0-5615d4e42262', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 18:19:17.478327+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cea13b8d-10db-4607-95e5-573326a4b39b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 18:19:17.479001+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e5656954-fb47-4ce8-9384-900085a8941d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 19:18:46.355904+00', ''),
	('00000000-0000-0000-0000-000000000000', '408bcb26-3879-41fc-b59c-5d8464a9d54e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 19:18:46.356495+00', ''),
	('00000000-0000-0000-0000-000000000000', '18641686-283f-46f8-a71b-6c0c4693bfa1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 20:44:42.188706+00', ''),
	('00000000-0000-0000-0000-000000000000', '75d74d3b-d5f0-4380-bd6b-8d5aea3820a9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 20:44:42.189423+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc6751c7-1ea0-4166-8770-07feb6033485', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 21:51:42.112028+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ca85ba4b-970b-498c-b70e-f249db073cbf', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 21:51:42.112778+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eab22b8b-2f2b-4c49-96d2-4bc9db5b1e02', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 22:49:45.494294+00', ''),
	('00000000-0000-0000-0000-000000000000', '7094df13-059a-4ab4-bb97-c7725471e7f9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 22:49:45.49489+00', ''),
	('00000000-0000-0000-0000-000000000000', '3f3c84c0-d630-487b-9788-9b567f6ef303', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 23:47:58.156423+00', ''),
	('00000000-0000-0000-0000-000000000000', '76005f5e-b785-45ff-a7fb-dade9fe728f7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-12 23:47:58.157057+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a5c2c521-3a3e-457a-bac0-18d878a7c96b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-13 00:45:58.625703+00', ''),
	('00000000-0000-0000-0000-000000000000', '113092ac-8af3-40a4-a419-dd259eb33c9f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-13 00:45:58.626316+00', ''),
	('00000000-0000-0000-0000-000000000000', 'edd9854e-4a6e-49f8-a74b-39348051e3a8', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 18:01:47.621761+00', ''),
	('00000000-0000-0000-0000-000000000000', '845f9e96-2b89-4a9d-ad93-f5b79c0a0b6b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 18:01:47.623328+00', ''),
	('00000000-0000-0000-0000-000000000000', '9704cc37-925e-48a8-b2e8-e08b60bb8c97', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-12-15 18:01:48.051587+00', ''),
	('00000000-0000-0000-0000-000000000000', '45086923-fb35-4647-b0ee-f17fe02bfcf7', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-12-15 18:01:54.383295+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b8766078-64be-47ee-924f-3a94a3c6c1e0', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 19:11:56.829842+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e9c8e63f-974f-4db6-8b61-1d6e63d7881f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 19:11:56.831439+00', ''),
	('00000000-0000-0000-0000-000000000000', '647fcdf8-f880-47dc-9189-2f93b37b9094', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2023-12-15 19:11:56.994539+00', ''),
	('00000000-0000-0000-0000-000000000000', '7a3657b8-38ee-4c28-89f4-4cc1efe88f72', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2023-12-15 19:26:49.192672+00', ''),
	('00000000-0000-0000-0000-000000000000', '5b4abb59-a513-4096-b487-b3eddd249a99', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 21:09:42.629799+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c297508f-50b6-4783-8e09-c654a2606377', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 21:09:42.631141+00', ''),
	('00000000-0000-0000-0000-000000000000', '1bd18e2c-4856-4671-afe3-2020dbfafdaa', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 22:23:17.537578+00', ''),
	('00000000-0000-0000-0000-000000000000', '1d90bb02-8a45-488a-8bf0-ae83692fe49c', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-15 22:23:17.538941+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dd708c6c-374f-4471-9a8e-ab2dc16918ac', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-16 00:23:06.422123+00', ''),
	('00000000-0000-0000-0000-000000000000', '66b7244a-f7c0-4274-812c-040d8a52dad6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-16 00:23:06.422773+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b861bbd9-e84c-4a13-9a96-4387907da441', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-18 17:17:54.183823+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b284bf94-66f0-43ef-884d-ed46f1cb4ba6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-18 17:17:54.185853+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc95f001-94eb-46ab-a571-f28841ffbcdc', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-18 19:32:28.128458+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e9ed8cb2-b8e8-448d-b903-17ec9751784e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-18 19:32:28.13133+00', ''),
	('00000000-0000-0000-0000-000000000000', '318616ef-cf6b-416f-a066-d087b214e95b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-19 19:36:24.610395+00', ''),
	('00000000-0000-0000-0000-000000000000', '3f0aa93f-12f9-4f33-9fc8-ea7360e8f0d3', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-19 19:36:24.612997+00', ''),
	('00000000-0000-0000-0000-000000000000', '70427679-1220-4778-8f46-57cf37063368', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-19 21:11:43.439597+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cfc82064-fd13-41a2-9599-75bbb6da869a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2023-12-19 21:11:43.440313+00', ''),
	('00000000-0000-0000-0000-000000000000', '1db2dda5-4c56-4e4b-815b-65493318a55f', '{"action":"login","actor_id":"40db71eb-68d2-402a-ae3f-6bd099418409","actor_username":"distributor@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-01-08 18:41:40.387393+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b378372f-04ea-4841-9482-fca27f51ea23', '{"action":"token_refreshed","actor_id":"40db71eb-68d2-402a-ae3f-6bd099418409","actor_username":"distributor@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-01-09 21:26:47.432759+00', ''),
	('00000000-0000-0000-0000-000000000000', 'da536cb6-780b-48b2-8bd7-6ae4bfff0d46', '{"action":"token_revoked","actor_id":"40db71eb-68d2-402a-ae3f-6bd099418409","actor_username":"distributor@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-01-09 21:26:47.433334+00', ''),
	('00000000-0000-0000-0000-000000000000', '1f7a3d05-6e14-478e-94a0-ea96fbcb76eb', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-02-21 00:55:59.552427+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ca3e26fe-b5f3-4b2b-a333-e95293ac8118', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 16:30:38.360856+00', ''),
	('00000000-0000-0000-0000-000000000000', '25292e56-c393-409b-b9bc-49e3044016ce', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 16:30:38.361403+00', ''),
	('00000000-0000-0000-0000-000000000000', '42dad43d-b9ce-4006-9b01-1fa1b74e1566', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 17:48:57.274014+00', ''),
	('00000000-0000-0000-0000-000000000000', '53e47219-45e3-4eaf-a350-cc33aa308a3c', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 17:48:57.274592+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bfa76c85-09be-4716-aead-8b0480241a21', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 21:44:06.743114+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c8d967b9-1c47-4fc1-8b33-f36c2b096f83', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 21:44:06.743755+00', ''),
	('00000000-0000-0000-0000-000000000000', '0c000fff-41fd-4b4b-9d45-24fdd85f5efb', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 22:42:19.878594+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b827471a-bb3e-4b21-a9d8-60ce85ae3ee0', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 22:42:19.87919+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e6c4f271-4970-4993-b351-996a08f40608', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 23:40:34.415211+00', ''),
	('00000000-0000-0000-0000-000000000000', '677e9354-162e-4c58-9e8c-170ac7cb0eab', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-21 23:40:34.41599+00', ''),
	('00000000-0000-0000-0000-000000000000', '8564687f-11a4-4398-b56e-c50bd66a8018', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 00:38:57.121186+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b35b51c7-c7a4-4f0d-b922-b1de35681803', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 00:38:57.1218+00', ''),
	('00000000-0000-0000-0000-000000000000', '2b2efb2c-8cbf-4dda-9266-3b1f7f1e1ebc', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 16:51:44.277219+00', ''),
	('00000000-0000-0000-0000-000000000000', 'df2ac7b7-e1d1-410e-b999-0320bc48cb0f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 16:51:44.278084+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cda44a60-b3a8-4f6c-b43f-a649b95cfe73', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-02-22 16:51:44.669855+00', ''),
	('00000000-0000-0000-0000-000000000000', '902f10b4-b171-452c-866b-5ecb115535e2', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-02-22 16:51:51.46076+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e70309d5-9053-4f4a-aab3-b7f29eded619', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 17:50:12.621213+00', ''),
	('00000000-0000-0000-0000-000000000000', '2435b1fc-0711-4542-b72c-5f1dd82642fd', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 17:50:12.621859+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bf568638-2c93-4406-a321-2b3e3607d430', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 18:48:13.281125+00', ''),
	('00000000-0000-0000-0000-000000000000', '03a510e9-bc17-4ad8-ad0c-c78409690ac6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 18:48:13.281719+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fe81fe73-b257-4f96-abf2-78575c210f93', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 19:46:30.781901+00', ''),
	('00000000-0000-0000-0000-000000000000', '4f2cd0b5-925f-4bb7-8566-c91c6d810457', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 19:46:30.784089+00', ''),
	('00000000-0000-0000-0000-000000000000', '2d09949f-b67a-4e1f-806d-2ec1d1ef5c2e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 20:49:05.394076+00', ''),
	('00000000-0000-0000-0000-000000000000', '8437e0d1-2953-4ce2-b4a0-5e73dd921afa', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 20:49:05.394736+00', ''),
	('00000000-0000-0000-0000-000000000000', 'be85c80b-4056-42ab-8694-db0715c15a03', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 21:47:10.043635+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a90e8862-2ec2-436f-b0e2-47128135867e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 21:47:10.044242+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd81ea3fb-119e-4358-9666-524891039709', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 22:46:28.445228+00', ''),
	('00000000-0000-0000-0000-000000000000', '8abb6c30-f1ae-4715-a3a4-6fbeb18543f1', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 22:46:28.445809+00', ''),
	('00000000-0000-0000-0000-000000000000', '6ff6f5c2-fdff-4218-aa48-a29213235d0f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 23:44:41.314227+00', ''),
	('00000000-0000-0000-0000-000000000000', '38e2f088-226d-43d7-ba05-07c8684e208d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-22 23:44:41.314796+00', ''),
	('00000000-0000-0000-0000-000000000000', '67d0d9a5-38c2-44bf-885d-03cd8ac08031', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 16:25:22.586056+00', ''),
	('00000000-0000-0000-0000-000000000000', '9923c378-42ce-4008-96e2-fc6557ff0e45', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 16:25:22.586621+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a9423a5a-85ea-4c39-a4b4-6d622af9f5b2', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 17:53:41.162206+00', ''),
	('00000000-0000-0000-0000-000000000000', '2d03b0db-8260-41c3-86b5-7da42e61eaa9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 17:53:41.162827+00', ''),
	('00000000-0000-0000-0000-000000000000', '2b092690-c1de-4834-b1c3-8c1c3681e2d5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 18:56:45.1628+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f71794b-ef4c-4509-8902-a2229cad35df', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 18:56:45.163458+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cf19248f-06dc-4277-9a0f-12814f58988e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 19:54:58.975769+00', ''),
	('00000000-0000-0000-0000-000000000000', '7d91a5f8-9fcc-48ad-85eb-63531be3e33a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 19:54:58.976363+00', ''),
	('00000000-0000-0000-0000-000000000000', '8757d34c-acdb-4d27-a8bd-285c45f374a7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 21:06:12.552279+00', ''),
	('00000000-0000-0000-0000-000000000000', '2916d529-610a-44ad-b7c4-f6f37005ce53', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 21:06:12.552838+00', ''),
	('00000000-0000-0000-0000-000000000000', '4cb81ad2-2453-4641-9435-ad11c5397011', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 22:07:01.987234+00', ''),
	('00000000-0000-0000-0000-000000000000', '99e488ae-ba55-4070-b879-6f99dd46137e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 22:07:01.989419+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b8698d64-4c11-47fc-b062-7c9c2a62add4', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 23:28:35.329145+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a36464f7-2e8f-4558-9f19-a7e6519649e0', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-23 23:28:35.329769+00', ''),
	('00000000-0000-0000-0000-000000000000', '0c20ce89-c1b5-4ee2-9575-d27b1606e1ca', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-24 00:56:18.176911+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd0859faf-c323-49c6-b134-cc46f96cc5f5', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-24 00:56:18.177466+00', ''),
	('00000000-0000-0000-0000-000000000000', '52c0ed12-6188-430e-8db0-10d534757fc8', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 17:03:53.470666+00', ''),
	('00000000-0000-0000-0000-000000000000', '00521c9b-a5e0-4e72-bd29-6bddc08b7c54', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 17:03:53.47263+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ba658f4e-1076-4689-8aee-c9a4f4dcd0e3', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-02-27 17:03:53.63915+00', ''),
	('00000000-0000-0000-0000-000000000000', '81cc12b3-0b06-45e2-a63d-dde21e252f11', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-02-27 17:04:35.457815+00', ''),
	('00000000-0000-0000-0000-000000000000', '950cec95-f3b1-4398-8c98-88f65d9d349c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 18:03:31.293634+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e0be33d7-acfd-4d02-b36a-152b8e59d61b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 18:03:31.294213+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b63de3c4-c0fa-44af-94e5-1fe4d563fd1f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 19:01:42.598248+00', ''),
	('00000000-0000-0000-0000-000000000000', '80f87637-5215-42be-9188-30e620fcbb33', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 19:01:42.598858+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a00d9d14-9811-4082-aa22-d7d3e11ec19b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 20:11:04.571928+00', ''),
	('00000000-0000-0000-0000-000000000000', '31a51899-8c12-4cee-bd25-b8f16f6600d8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 20:11:04.572493+00', ''),
	('00000000-0000-0000-0000-000000000000', '058b2791-0b61-445e-88f8-ce49c8b42a42', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 21:42:06.328502+00', ''),
	('00000000-0000-0000-0000-000000000000', '4989c0ec-497c-4924-9607-625e582b961e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 21:42:06.329091+00', ''),
	('00000000-0000-0000-0000-000000000000', '89ae996d-7f32-4dcd-8244-9e05499861e6', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 21:42:06.585311+00', ''),
	('00000000-0000-0000-0000-000000000000', '7635052d-1859-4ea9-82f7-f36c66130587', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-02-27 21:42:06.73698+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cdf66e65-b570-485f-8215-15f96e72d89d', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-02-27 21:42:09.440813+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bd5da6a8-2228-47a9-8e02-d24c19e3fbcf', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 22:40:48.566455+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd418aadd-d687-415f-b76f-d5a7437aea59', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 22:40:48.567028+00', ''),
	('00000000-0000-0000-0000-000000000000', '5016d219-0364-4d73-88c2-553e38c82396', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 23:40:49.925136+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e727ef78-9a68-4c8e-a6f6-2014884776a2', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-27 23:40:49.925703+00', ''),
	('00000000-0000-0000-0000-000000000000', '95e76b63-b60b-44fe-99bb-34058d54be8e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 00:45:00.457945+00', ''),
	('00000000-0000-0000-0000-000000000000', '862b8581-d9dc-4405-8a96-28f60a25faa3', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 00:45:00.458587+00', ''),
	('00000000-0000-0000-0000-000000000000', '36b1c9d9-2c38-4e56-99c0-cc17837ff47c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 16:48:24.988817+00', ''),
	('00000000-0000-0000-0000-000000000000', '06a6a327-f862-4049-a16c-375ecee6052c', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 16:48:24.991306+00', ''),
	('00000000-0000-0000-0000-000000000000', '8208d2b3-35ad-480d-9e97-9cbf6f7eecf2', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-02-28 16:48:25.125469+00', ''),
	('00000000-0000-0000-0000-000000000000', '54027452-6960-4a39-aa13-a5a95e0bb447', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-02-28 16:48:29.302752+00', ''),
	('00000000-0000-0000-0000-000000000000', '32638c81-e206-4254-a652-53f454ebbe72', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 17:48:53.800115+00', ''),
	('00000000-0000-0000-0000-000000000000', '4ca6fdeb-0dbf-4343-89e6-700581d2c3c9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 17:48:53.801531+00', ''),
	('00000000-0000-0000-0000-000000000000', '69a6fb12-0738-421c-8934-e16196b6f6c4', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 18:47:00.961136+00', ''),
	('00000000-0000-0000-0000-000000000000', '065f1f8b-5b89-402c-8ede-05e44371547a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 18:47:00.962509+00', ''),
	('00000000-0000-0000-0000-000000000000', '6092c24b-a25b-4bff-bb8e-e7366f7e4916', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 20:46:10.799969+00', ''),
	('00000000-0000-0000-0000-000000000000', '9ff5462d-ccfa-4fc0-ac0e-5f7b6fc6fe48', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 20:46:10.800762+00', ''),
	('00000000-0000-0000-0000-000000000000', '4aa1c1aa-f450-45ed-8d1b-a60a390479c6', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 21:47:21.214677+00', ''),
	('00000000-0000-0000-0000-000000000000', '0ac2ef90-4d3a-4ef3-8df6-66d73923e6ac', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 21:47:21.215417+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ed8f0075-2eee-44b8-bcaf-04863e5111b6', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 23:18:35.321111+00', ''),
	('00000000-0000-0000-0000-000000000000', '38ab3c21-2288-4c57-92b3-a90f363d4ff3', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-28 23:18:35.322245+00', ''),
	('00000000-0000-0000-0000-000000000000', '4d5206a0-4ec5-414c-bfe3-e9339159caf7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 00:19:57.473618+00', ''),
	('00000000-0000-0000-0000-000000000000', '73bda642-691d-4c8f-b0de-28b1699f50ef', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 00:19:57.474246+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e37a285-cc87-41ed-ad59-e2321a846756', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 16:16:47.277567+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e46a2a0-f296-4054-961d-1f02ccecaf45', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 16:16:47.278736+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd21054d0-ac46-4dcf-98a8-d314989fd0e1', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-02-29 16:16:47.465633+00', ''),
	('00000000-0000-0000-0000-000000000000', '69babed6-0ec7-48cf-8f66-8b44f8e612e7', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-02-29 16:32:53.173467+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c05f77fb-a601-46de-b5c1-1452c2f52e46', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 17:52:08.110812+00', ''),
	('00000000-0000-0000-0000-000000000000', '1dfcffc4-6171-4a26-a370-b9bb7a31fe5a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 17:52:08.111395+00', ''),
	('00000000-0000-0000-0000-000000000000', '6dcbc5f0-8351-4dc7-87ba-8e3772204de3', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-02-29 17:52:08.521425+00', ''),
	('00000000-0000-0000-0000-000000000000', '3dcf48e0-a8ca-4054-af88-bdb6abf5f5a3', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-02-29 17:52:10.797877+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c338fc17-e43b-41ab-8a1b-291ab6bdc3ef', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 19:07:19.923811+00', ''),
	('00000000-0000-0000-0000-000000000000', '690084e2-3a30-406d-b03b-27d8d00fde46', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 19:07:19.925544+00', ''),
	('00000000-0000-0000-0000-000000000000', '7132a155-aedd-4603-bf1c-cd07f32767fa', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 20:58:11.163283+00', ''),
	('00000000-0000-0000-0000-000000000000', '33f72a92-b3b4-4c01-8a97-500378f254b8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 20:58:11.164523+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cdea8190-9f94-4e88-94ff-9f60486bfb94', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 22:27:16.891471+00', ''),
	('00000000-0000-0000-0000-000000000000', '5c1d99a4-067c-45a5-9d24-e03e40116cdb', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 22:27:16.892732+00', ''),
	('00000000-0000-0000-0000-000000000000', '5a197bb9-d5e1-4519-8869-1d145a13999e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 23:29:33.58797+00', ''),
	('00000000-0000-0000-0000-000000000000', '27a62f6f-a261-4340-9ad1-861267d833e9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-02-29 23:29:33.588566+00', ''),
	('00000000-0000-0000-0000-000000000000', '505f7f4d-a99a-4ac4-99e2-f7a118b43178', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 00:27:55.241735+00', ''),
	('00000000-0000-0000-0000-000000000000', '7468bc4a-2f87-4b41-9344-4dbd570468fe', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 00:27:55.242298+00', ''),
	('00000000-0000-0000-0000-000000000000', '2166ec13-8ebe-499a-8abe-bfb71db2ac4e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 16:56:41.009552+00', ''),
	('00000000-0000-0000-0000-000000000000', '0ca303cd-bc7c-47b2-b88e-4d9e5d54ae39', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 16:56:41.010939+00', ''),
	('00000000-0000-0000-0000-000000000000', '83868eae-8bd1-43dc-a195-29b4dcd5f8e5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 17:58:23.650856+00', ''),
	('00000000-0000-0000-0000-000000000000', '5b4efff9-596c-45a1-80a0-4203cfa2bde6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 17:58:23.65141+00', ''),
	('00000000-0000-0000-0000-000000000000', '44fffb4e-a546-4170-ae08-0f7007410658', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 18:56:28.845918+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a6d8b0d5-52f8-473a-bd36-b22a687ed17f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 18:56:28.84706+00', ''),
	('00000000-0000-0000-0000-000000000000', 'df80833e-a8f3-45d3-897a-8d1c6589712f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 19:57:35.476658+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e13d6db8-64cd-46ac-ac95-e11069da9cd0', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 19:57:35.477234+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e1fbb57d-f4f1-4d99-a518-508be2ac8772', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-01 19:57:35.977043+00', ''),
	('00000000-0000-0000-0000-000000000000', '089e2ce6-5014-45f7-ad62-815f29111c42', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-01 19:57:42.558935+00', ''),
	('00000000-0000-0000-0000-000000000000', '39a6db25-2788-43bf-a051-9a3b95eba56c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 21:01:07.105722+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd7f6da35-a2a6-446f-b78c-19a1bf7397ec', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 21:01:07.106319+00', ''),
	('00000000-0000-0000-0000-000000000000', '2cb41fbc-2cd7-4ce8-b775-8f5bc96e455d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 21:59:30.059485+00', ''),
	('00000000-0000-0000-0000-000000000000', '4b946efe-dce3-4cc4-a669-4f0d6d4e8df8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 21:59:30.060102+00', ''),
	('00000000-0000-0000-0000-000000000000', '37c110cf-21b7-4859-9972-374c5f3ae074', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 22:58:15.114015+00', ''),
	('00000000-0000-0000-0000-000000000000', '843a529a-fece-4172-9e9e-a922c6379386', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-01 22:58:15.115347+00', ''),
	('00000000-0000-0000-0000-000000000000', '59e07aa7-5cbf-41a2-886e-c5bc030d4ea1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-02 00:03:23.636076+00', ''),
	('00000000-0000-0000-0000-000000000000', '66664e8e-6b66-4a79-86d3-508af76437e2', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-02 00:03:23.636676+00', ''),
	('00000000-0000-0000-0000-000000000000', '6c34034e-79f3-4d26-84d0-a75a7bfd28a9', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-04 17:19:23.574056+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a71e7841-9bbf-4d2d-9c67-1f6e423c4476', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-04 17:19:23.576108+00', ''),
	('00000000-0000-0000-0000-000000000000', '3770a396-cde2-4859-acef-71648e33b82a', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-04 17:19:23.708563+00', ''),
	('00000000-0000-0000-0000-000000000000', '026b9118-0c68-4952-aa47-12ee125a3614', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-04 17:19:25.493571+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b7d46f7c-35b1-44f7-9bd1-5ccd6f1c46fc', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-04 18:29:11.76062+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a3a1a735-8274-423b-bbfa-222dd6aca884', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-04 18:29:11.761801+00', ''),
	('00000000-0000-0000-0000-000000000000', '7b0ebf89-63de-4588-b3ec-3628c2e21682', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-04 19:34:08.623646+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f833ac38-0501-4464-b7ed-e9651f487148', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-04 19:34:08.625126+00', ''),
	('00000000-0000-0000-0000-000000000000', '17d1189a-919f-4829-ad14-9f5d1a446d3d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-05 19:30:07.895046+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b1df8137-4c58-4a0a-a284-4e10718f05e6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-05 19:30:07.897196+00', ''),
	('00000000-0000-0000-0000-000000000000', 'beb7d3cf-c7fb-4361-b92e-154ea027bf28', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-05 19:30:08.041377+00', ''),
	('00000000-0000-0000-0000-000000000000', 'de45db14-e454-4566-b980-d18f7fa3e2dc', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-05 19:30:09.92294+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d6a389b-5838-4517-9dbf-c73940601239', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-05 21:26:20.271589+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fd7a386d-c5df-476b-a143-65f042078cd8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-05 21:26:20.272924+00', ''),
	('00000000-0000-0000-0000-000000000000', '26036c3d-e13b-4bf1-b6ab-3a100e0ec5ee', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-05 21:26:20.573338+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b36bbff5-1183-4281-b59d-9633e0b34e51', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-05 21:26:22.292346+00', ''),
	('00000000-0000-0000-0000-000000000000', '3eb858b4-bf71-4837-93ad-1057b1e48126', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-05 22:24:41.826717+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c4cbe2a8-2515-46a3-9cd0-508259229558', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-05 22:24:41.82793+00', ''),
	('00000000-0000-0000-0000-000000000000', '26693bc7-649c-4b88-a049-87dbe8859fee', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 00:31:58.862018+00', ''),
	('00000000-0000-0000-0000-000000000000', '35d6aa34-c17f-4190-9bdd-1c6c58441917', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 00:31:58.862618+00', ''),
	('00000000-0000-0000-0000-000000000000', '725963f3-fae8-4dd7-9298-16e9a26f1a44', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 16:56:48.908187+00', ''),
	('00000000-0000-0000-0000-000000000000', '3aa0e6b6-f989-4c4b-87d0-3cfcee8f130b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 16:56:48.908787+00', ''),
	('00000000-0000-0000-0000-000000000000', '848dd5e4-74ae-44a4-ba67-0405032f225c', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-06 16:56:49.244437+00', ''),
	('00000000-0000-0000-0000-000000000000', '9c155d47-189d-4bc5-b88e-ec2abae5ed60', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-06 16:56:51.802853+00', ''),
	('00000000-0000-0000-0000-000000000000', '8d699b7f-bf87-4e5b-83dd-38267bf3c522', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 17:55:16.80272+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cbe65185-bb97-4da8-af66-26fbb0211c48', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 17:55:16.804923+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e80a8591-7fa6-46c5-b2ea-6492e048aeb7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 18:53:36.11372+00', ''),
	('00000000-0000-0000-0000-000000000000', '81fcff74-8c21-43a5-8c2e-d32594db309b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 18:53:36.114352+00', ''),
	('00000000-0000-0000-0000-000000000000', '33c5b4ad-dce9-40b2-baf0-360cac2ea15a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 19:52:03.606749+00', ''),
	('00000000-0000-0000-0000-000000000000', '587424a8-2b7a-453b-a26d-04dd6a890245', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 19:52:03.607316+00', ''),
	('00000000-0000-0000-0000-000000000000', '073f604a-15c9-430a-85c4-b4390dfa00ae', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 23:12:20.515048+00', ''),
	('00000000-0000-0000-0000-000000000000', '0fab9e7d-6886-4a4c-955c-a1235bc49977', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-06 23:12:20.516338+00', ''),
	('00000000-0000-0000-0000-000000000000', '9a53c022-9c7a-41dd-9171-de06254bb02c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 00:28:57.081023+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e7ee6689-0303-4ea9-a5bf-57ad4f747b86', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 00:28:57.081607+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b94fc018-e850-4169-b704-7297efff2fad', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 00:28:57.235432+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c4227f5e-f251-4842-87d0-a6253e5fc938', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 16:12:43.421245+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dbb61b6e-7e05-40f6-830b-76ccce99998d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 16:12:43.422361+00', ''),
	('00000000-0000-0000-0000-000000000000', '5fddb276-b7c4-4beb-9b8a-83a0b3607d41', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 17:52:10.16723+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd3673054-f0d1-468a-a663-2860072d70cd', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 17:52:10.168791+00', ''),
	('00000000-0000-0000-0000-000000000000', '4f9ccbd9-605d-4eaa-9952-fbd70aa6de76', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 18:50:30.782271+00', ''),
	('00000000-0000-0000-0000-000000000000', '29d0d641-59c3-4721-a17c-e63b5336aca8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-07 18:50:30.787368+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d58b506-28c0-45de-9dfb-d28f6d5433d4', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 18:21:10.352613+00', ''),
	('00000000-0000-0000-0000-000000000000', '7b555885-44b0-4925-af6d-9bd8c646d955', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 18:21:10.353677+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fab1d28c-554c-4aee-a48e-378e57d1f2ed', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 19:32:56.760173+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd9e3c892-0a5f-4546-87d9-193f0f49b392', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 19:32:56.761285+00', ''),
	('00000000-0000-0000-0000-000000000000', '52c2910b-d87b-4f9f-b2e0-28692cffc7ab', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-08 19:32:56.877896+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bd52e066-62bf-4c0c-8863-46eef5d65422', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-08 20:12:22.330303+00', ''),
	('00000000-0000-0000-0000-000000000000', '9a5c26ff-453a-4f9d-8dc9-e9272aee45ec', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 21:34:45.821106+00', ''),
	('00000000-0000-0000-0000-000000000000', '53d78adc-89c3-4b29-b737-e3b9d95b4b09', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 21:34:45.82462+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b76ab5bb-c86e-4a3a-a0d2-5fa9ab71a087', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 22:35:38.326016+00', ''),
	('00000000-0000-0000-0000-000000000000', '78f07457-7570-41db-ace0-1d4797e58806', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-08 22:35:38.327198+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd1701624-0480-4088-88b1-286c3473b8cf', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-09 00:30:01.653993+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b9b541e-8cf8-42d3-ae2a-9fc359aaf5f8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-09 00:30:01.654676+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c3e4ae3e-1444-4d2d-80e8-531e4e337cf1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 15:22:48.739012+00', ''),
	('00000000-0000-0000-0000-000000000000', '011dccbe-e9ee-485b-ace8-bbd4dc10fda6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 15:22:48.740669+00', ''),
	('00000000-0000-0000-0000-000000000000', '442d1d1b-ca24-4689-a35b-4f3001eb19aa', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-11 15:22:49.18583+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b4534d24-d6a0-45f5-a8a7-2be02a803948', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-11 15:22:51.137964+00', ''),
	('00000000-0000-0000-0000-000000000000', '4ca6ef3f-bdc3-4dc6-8bfe-836b10a1825a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 16:50:29.735221+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b89d6ddc-cedb-4b00-af9c-3a3dbcb55856', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 16:50:29.736326+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b8ed755b-e0e7-4e49-b6c7-159236d3c375', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 17:48:55.814517+00', ''),
	('00000000-0000-0000-0000-000000000000', '1fe65613-8002-40ce-88cc-1a827d75c4f1', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 17:48:55.817014+00', ''),
	('00000000-0000-0000-0000-000000000000', '35ff8b0e-aa50-4950-9177-f21e1c4e25a5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 18:47:24.88404+00', ''),
	('00000000-0000-0000-0000-000000000000', '300a0fc5-87d3-4138-b6e4-335d53af4c31', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 18:47:24.885488+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc9ee2e7-45a5-4783-b463-a50917aef90c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 19:57:37.233021+00', ''),
	('00000000-0000-0000-0000-000000000000', '24594aa8-955d-4a97-9176-8af8da95cbdf', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 19:57:37.234515+00', ''),
	('00000000-0000-0000-0000-000000000000', '1ee469d4-d552-4faa-89ec-1f3f3bfcfd28', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-11 19:57:37.37233+00', ''),
	('00000000-0000-0000-0000-000000000000', '82f818e2-2eea-4aed-a789-9baaeddbc3f2', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-11 20:39:30.729836+00', ''),
	('00000000-0000-0000-0000-000000000000', '486f9b58-c912-421c-96a8-e22a8a33bd8b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 21:50:41.28043+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c7e8a25c-9030-4363-8612-477ee97e7c86', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 21:50:41.282587+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ec979d96-64d6-4700-ac4e-1aa786512def', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 22:48:46.332155+00', ''),
	('00000000-0000-0000-0000-000000000000', '27e8a7ae-ceda-48e1-956e-cd5dbfc981b7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-11 22:48:46.333892+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5ff7d36-237f-46a4-93eb-7a0a8fad4874', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 15:31:30.09746+00', ''),
	('00000000-0000-0000-0000-000000000000', '6df78b5e-6c96-4849-aab8-4de2023c37b8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 15:31:30.099828+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b30c3817-4ae0-4948-a34b-56dcfca209a2', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-12 15:31:30.222598+00', ''),
	('00000000-0000-0000-0000-000000000000', '67ee4462-fcd9-4694-af7c-f41891592a34', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-12 15:31:32.814852+00', ''),
	('00000000-0000-0000-0000-000000000000', '74460a48-a821-47b1-b949-53c1c3df1226', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 17:04:34.530519+00', ''),
	('00000000-0000-0000-0000-000000000000', '9cb266b6-bece-413d-a8cf-d2d4f141da6f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 17:04:34.531787+00', ''),
	('00000000-0000-0000-0000-000000000000', '5bf24d5e-1f26-4c29-96b4-74351a8a505f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 18:17:26.851773+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e111fb1-daab-4996-a457-606853df8170', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 18:17:26.853256+00', ''),
	('00000000-0000-0000-0000-000000000000', '498fc9f6-520c-415b-8e75-71c58419441c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 19:38:49.307255+00', ''),
	('00000000-0000-0000-0000-000000000000', '2cb52d79-74a3-4d1c-8a9d-33708cc79a0b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 19:38:49.309504+00', ''),
	('00000000-0000-0000-0000-000000000000', '66924fa4-5396-4305-b03f-fe806a84eaf0', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 20:36:51.825871+00', ''),
	('00000000-0000-0000-0000-000000000000', '99b8d044-7f10-4379-8ab3-ab54aaf2edba', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 20:36:51.82951+00', ''),
	('00000000-0000-0000-0000-000000000000', 'addc63b7-c5dd-4b85-a6c2-83145b3949d7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 22:54:30.151923+00', ''),
	('00000000-0000-0000-0000-000000000000', '520170fa-22ff-4684-a9b3-d9a975b77106', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-12 22:54:30.152987+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ef72f44b-c096-496a-96e0-a6ae9b97c048', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 15:17:25.404799+00', ''),
	('00000000-0000-0000-0000-000000000000', '44ece96a-975d-450e-a78a-8c548034b0d6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 15:17:25.407874+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bf26a921-e0a4-44d7-a5f2-7f6e25e48c82', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-13 15:17:25.542958+00', ''),
	('00000000-0000-0000-0000-000000000000', '2e6d1837-11a6-463a-bc40-a3c0417edafb', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-13 15:17:29.525103+00', ''),
	('00000000-0000-0000-0000-000000000000', '23d1932c-5c22-4d42-945e-b8cf35e5f906', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 16:18:31.022458+00', ''),
	('00000000-0000-0000-0000-000000000000', '89ca2e6f-803e-4f98-aeed-cd156e0b884a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 16:18:31.024395+00', ''),
	('00000000-0000-0000-0000-000000000000', '96a7a8d5-0850-4d85-96d2-22a6a44759b5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 17:19:01.735697+00', ''),
	('00000000-0000-0000-0000-000000000000', '4507f778-5838-4568-9d5c-18806530734d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 17:19:01.736774+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd5112b16-e941-48f5-af65-04a0fa9b233f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 18:17:30.263697+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a7a7e3e-68f2-49a1-ac83-53c40056a5d9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 18:17:30.264746+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c2396e8d-7e2b-4967-8cb4-705188f741e2', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 19:36:09.119183+00', ''),
	('00000000-0000-0000-0000-000000000000', '5af65274-e458-4e4b-ae76-d2f197f60cda', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 19:36:09.121558+00', ''),
	('00000000-0000-0000-0000-000000000000', '61004811-ce2f-478c-88c8-e8e165c1a43f', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-13 20:11:59.155917+00', ''),
	('00000000-0000-0000-0000-000000000000', '26c268d5-fc7d-4e0b-bbc2-2e56fecac245', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-13 20:12:14.15116+00', ''),
	('00000000-0000-0000-0000-000000000000', '7d7d95fc-5a78-48e2-aa80-3effc6f2fdce', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 23:04:20.216465+00', ''),
	('00000000-0000-0000-0000-000000000000', '69463331-35d0-44c2-9c42-7ae6d6bf6e16', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-13 23:04:20.219681+00', ''),
	('00000000-0000-0000-0000-000000000000', '41a36d24-e243-4c22-9495-33871db1d841', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-13 23:04:20.349452+00', ''),
	('00000000-0000-0000-0000-000000000000', '5dc683eb-d417-49ee-a31f-a3e3b5e98ec3', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-13 23:04:30.281824+00', ''),
	('00000000-0000-0000-0000-000000000000', '29820d50-7a6c-449b-a054-d2ee70983b00', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-14 15:03:27.405428+00', ''),
	('00000000-0000-0000-0000-000000000000', '1cf6334b-ef18-47ca-93e4-9393d6e3ed24', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-14 15:03:27.408618+00', ''),
	('00000000-0000-0000-0000-000000000000', '36908cd2-1f21-464c-b8e8-4ed0b96ca923', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-14 23:27:50.633954+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ed968181-1ef3-486b-acea-ab340931fc97', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-15 15:05:26.037999+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cca1f821-817c-4ab1-9974-a1148b47c92d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-15 15:05:26.040068+00', ''),
	('00000000-0000-0000-0000-000000000000', '0f90d57e-4e50-4f3c-ad88-18fcc81c6e30', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-15 16:03:27.577043+00', ''),
	('00000000-0000-0000-0000-000000000000', 'adfc5e2c-6d07-4853-af99-6af9cdaa7261', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-15 16:03:27.578378+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e6ee1571-607e-4127-a948-c3444f3eadf1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-15 17:02:25.653976+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c98d8d53-bdc4-4f47-bde8-f1687d97154b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-15 17:02:25.657072+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b09e32ee-524f-4134-8941-39066a2fa1ab', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 15:09:29.707235+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f182f739-2150-4dd4-836b-3ead849ba6c9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 15:09:29.715269+00', ''),
	('00000000-0000-0000-0000-000000000000', '5d375811-9b8c-4d20-8417-15d400c5464f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 15:09:30.441727+00', ''),
	('00000000-0000-0000-0000-000000000000', '1084e911-13bf-4920-b2e6-0fcc262a3306', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-18 15:09:30.604262+00', ''),
	('00000000-0000-0000-0000-000000000000', '292b6b43-4203-4787-887c-643b30aeea41', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-18 15:09:32.865885+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a6cb5d8a-853c-43fe-8276-3dde62e84aca', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 16:08:02.19201+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ed689984-b67d-4514-a602-9fc64b9d8ba7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 16:08:02.193921+00', ''),
	('00000000-0000-0000-0000-000000000000', '0db6f511-cd9b-4e85-b006-d201f6ff27bd', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 17:08:33.527999+00', ''),
	('00000000-0000-0000-0000-000000000000', '518fbf92-27b2-475a-80c7-42bf62af6f07', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 17:08:33.530037+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cee1e24e-1bd7-471b-8bf6-fb8ff107c167', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 18:09:05.968102+00', ''),
	('00000000-0000-0000-0000-000000000000', '771bab75-9dd0-4c79-9cdd-f28773231bd2', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 18:09:05.969435+00', ''),
	('00000000-0000-0000-0000-000000000000', 'db775134-a705-43d6-b7ce-bdcce31eceec', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 19:40:17.733732+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e88ba270-be2e-4e68-bb31-e3286c79aa70', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 19:40:17.736045+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ff4f5ba5-c9b8-4c03-9a7c-94d6c86fed0d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 20:47:59.146968+00', ''),
	('00000000-0000-0000-0000-000000000000', '8c5b5420-0aaf-4005-8866-31a4b8220815', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 20:47:59.147543+00', ''),
	('00000000-0000-0000-0000-000000000000', '389ba376-ea62-4e41-a455-a9289148705d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 22:21:25.400082+00', ''),
	('00000000-0000-0000-0000-000000000000', '250f2b9a-d2f5-479a-a171-7bc861fec8f8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 22:21:25.401238+00', ''),
	('00000000-0000-0000-0000-000000000000', '1c59b473-f051-4f72-b16c-ca0c24c49d10', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 23:20:00.756606+00', ''),
	('00000000-0000-0000-0000-000000000000', '7db0d7e6-1692-4581-b76d-2e1702320a1d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-18 23:20:00.75782+00', ''),
	('00000000-0000-0000-0000-000000000000', '0979f0c0-becb-416b-82eb-5fbfbf18e7be', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 15:09:12.366567+00', ''),
	('00000000-0000-0000-0000-000000000000', '7e409b58-f8df-4688-b29c-e15c97bd2577', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 15:09:12.370719+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c15f87cf-60f6-4fec-8109-e1c2512e766b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 16:31:08.86514+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a6a26611-524a-462b-ac8c-19f1e02a14e1', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 16:31:08.868227+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f124768c-6688-49e6-b049-dab301cad8cb', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 17:29:16.619253+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a4e571d-7535-4696-b1fc-ce4bd825b62b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 17:29:16.620764+00', ''),
	('00000000-0000-0000-0000-000000000000', '76066516-6646-4940-8520-0b4c12286327', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 20:48:22.728463+00', ''),
	('00000000-0000-0000-0000-000000000000', '9f0891b1-9854-4abb-9e44-25ea6eb019b9', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 20:48:22.730578+00', ''),
	('00000000-0000-0000-0000-000000000000', '6128ad9f-cd8d-4365-8769-23291e5bf3eb', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 22:00:14.321913+00', ''),
	('00000000-0000-0000-0000-000000000000', '1f3c34ed-b182-4bba-9e28-cbc9f797ff6b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 22:00:14.323472+00', ''),
	('00000000-0000-0000-0000-000000000000', '269f2d48-5a0c-48ef-883c-a01ea204e786', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 22:58:41.249182+00', ''),
	('00000000-0000-0000-0000-000000000000', '36307fbf-2fb3-4667-963c-3b2e8afb570e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 22:58:41.250719+00', ''),
	('00000000-0000-0000-0000-000000000000', '9750e633-0d0e-4996-be42-cd61e2de44ff', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 23:57:49.868833+00', ''),
	('00000000-0000-0000-0000-000000000000', '020941c1-af8d-4b99-a5fd-895d6213a03f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-19 23:57:49.871646+00', ''),
	('00000000-0000-0000-0000-000000000000', '5ea6b7a9-db45-4872-b995-e4e49a97f1eb', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 17:52:47.032506+00', ''),
	('00000000-0000-0000-0000-000000000000', '9e64710b-a21f-48d7-a00a-d3578e6b33d4', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 17:52:47.037589+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f54c4ee3-ff59-4303-b50d-615fdd2c9a72', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-20 17:52:47.146637+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f72eaa94-964b-400e-b6bf-c2e1b7e7d0d5', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-20 17:52:50.166906+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f9f4aa08-8ca5-44bb-b1a1-2621103c0410', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-20 17:52:54.524399+00', ''),
	('00000000-0000-0000-0000-000000000000', '69705594-f800-40af-8d79-cdecd05fb2d5', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 18:53:20.750035+00', ''),
	('00000000-0000-0000-0000-000000000000', '25286228-0c38-4240-ad6a-bc0a57f7a194', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 18:53:20.751691+00', ''),
	('00000000-0000-0000-0000-000000000000', '13e78d24-9ff6-4971-b777-df3c4c851359', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 19:51:30.920503+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f9d4785-d7b6-4738-846d-c62f24f2e655', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 19:51:30.921473+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd0267386-bc2a-4bcf-b3d6-5ac217b64b51', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 20:51:23.599831+00', ''),
	('00000000-0000-0000-0000-000000000000', '9c474c2d-98b4-4010-9cbb-e5d962d9e17f', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 20:51:23.602191+00', ''),
	('00000000-0000-0000-0000-000000000000', '63a4c3a9-d8cd-4181-b605-bbeff1a15b8d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 21:49:37.324567+00', ''),
	('00000000-0000-0000-0000-000000000000', '42a90f0d-3c37-431a-9119-4bc926cd8480', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 21:49:37.325767+00', ''),
	('00000000-0000-0000-0000-000000000000', '627b0c0d-9f91-4734-b89b-79730462307a', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-20 22:33:03.449497+00', ''),
	('00000000-0000-0000-0000-000000000000', '7a9fa0e3-702e-442a-9aa5-668eafccab25', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-03-20 22:34:23.421061+00', ''),
	('00000000-0000-0000-0000-000000000000', 'da0e5193-acad-4d13-9978-9b1d42e13264', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-20 22:34:52.393157+00', ''),
	('00000000-0000-0000-0000-000000000000', '5c04764c-6bf7-4c48-bba7-d61f7148777d', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-20 22:40:24.809759+00', ''),
	('00000000-0000-0000-0000-000000000000', '01f8bfa1-fb75-42c9-a8c9-edaebc5f67a8', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jains@theoutdoorplus.com","user_id":"e24df0ac-6fe4-4d49-bd5a-7a566dc6b8ff","user_phone":""}}', '2024-03-20 23:05:42.558433+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bd35b313-3c11-437f-a341-efee18bcdbd7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 23:05:48.734793+00', ''),
	('00000000-0000-0000-0000-000000000000', '5de6e309-370d-4ec0-adce-6ce53c619534', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 23:05:48.735388+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a7af601b-7b5f-42f2-b144-beefa12553bd', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"jains@theoutdoorplus.com","user_id":"e24df0ac-6fe4-4d49-bd5a-7a566dc6b8ff","user_phone":""}}', '2024-03-20 23:06:27.686229+00', ''),
	('00000000-0000-0000-0000-000000000000', '1d50c534-fa89-4fb7-b7eb-07b5d626e8fb', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jains@theoutdoorplus.com","user_id":"e24df0ac-6fe4-4d49-bd5a-7a566dc6b8ff","user_phone":""}}', '2024-03-20 23:07:28.302718+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd390da58-5d19-45ad-9aae-966aa9a9b987', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jains@theoutdoorplus.com","user_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","user_phone":""}}', '2024-03-20 23:08:02.963517+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a8852f6e-c7f9-43d6-9ec1-632d7bf2411a', '{"action":"login","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-20 23:09:22.05999+00', ''),
	('00000000-0000-0000-0000-000000000000', '5cddc88d-94c4-4e51-af8d-51463edece87', '{"action":"logout","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-20 23:26:31.457815+00', ''),
	('00000000-0000-0000-0000-000000000000', '8652430b-9761-48e7-a25a-6a818c7ef0bc', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"daniel@theoutdoorplus.com","user_id":"8e267267-0d9a-45fe-b410-014304bcd044","user_phone":""}}', '2024-03-20 23:30:09.444595+00', ''),
	('00000000-0000-0000-0000-000000000000', '843d0787-45b3-41da-91cb-396668238458', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 23:33:18.975831+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c4915cea-9f0e-40b2-87bd-52623d49d5e8', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-03-20 23:33:18.976405+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ad67224d-5251-4172-b61f-e4017418cd71', '{"action":"login","actor_id":"8e267267-0d9a-45fe-b410-014304bcd044","actor_username":"daniel@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-20 23:34:03.413334+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cb673f99-10a0-4ddc-ad11-f6914f55bc24', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-03-22 23:02:56.894335+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d65ac8f-8a57-4128-8ef3-fc320c41995d', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-03-22 23:02:56.902926+00', ''),
	('00000000-0000-0000-0000-000000000000', '7fca3344-0526-45d8-b128-fef8d881b8f9', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-03-22 23:02:57.233103+00', ''),
	('00000000-0000-0000-0000-000000000000', '2526e5c0-b0a4-412f-b969-3155213dfe0a', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-22 23:04:10.365994+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b3de0cf0-1efa-4d3a-85b3-6573c2583849', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-25 21:28:16.442495+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e862e557-df01-41ba-a6c4-923d24265045', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-25 21:28:16.452888+00', ''),
	('00000000-0000-0000-0000-000000000000', '432863ef-f052-40b1-b5c8-be7f9ae7207b', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-25 21:28:16.628513+00', ''),
	('00000000-0000-0000-0000-000000000000', '9cb261c8-b1e3-490b-9b7e-2d2405ad7282', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-25 21:28:17.755988+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b38efb3c-0cc7-4fde-a80d-e209612ee045', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-25 22:26:32.513693+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c4a3db34-364f-49f7-9a15-f6db10a66e50', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-25 22:26:32.514778+00', ''),
	('00000000-0000-0000-0000-000000000000', '3d9ef708-abd8-49c1-8b30-bdef0d8818e4', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 14:57:36.326311+00', ''),
	('00000000-0000-0000-0000-000000000000', '1ce5c432-d2ee-488e-9a6c-b71cad0c4670', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 14:57:36.332709+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e0fa6f35-20ef-413f-9f56-1f847520091d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 18:09:38.464224+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e4676a31-e9ae-44fb-b79e-c390dccdf899', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 18:09:38.466286+00', ''),
	('00000000-0000-0000-0000-000000000000', '7384fae9-9688-45ce-9af3-a479cb795f0a', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-03-26 18:09:38.606189+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ef09f6ba-4619-44c2-9038-d6468664c560', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-26 18:15:00.373742+00', ''),
	('00000000-0000-0000-0000-000000000000', '2f473272-7aa7-4648-934d-6e0f75dfb4a5', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-26 18:42:00.646318+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f1b571ad-605d-447f-aeb2-f2fa400b5a81', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 19:50:14.074853+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a908bf18-eb5b-4722-a7a0-4f00d9ee59f7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 19:50:14.076136+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b899bf7b-7138-4a9f-9236-60fbb8b96866', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 20:48:17.960318+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cbd139db-071a-409b-bb43-0104495fe1d1', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 20:48:17.962363+00', ''),
	('00000000-0000-0000-0000-000000000000', '4de59627-7998-4f4d-ad06-5ff8f3b1d898', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 21:54:09.227256+00', ''),
	('00000000-0000-0000-0000-000000000000', '34f9b2e9-d2df-4e4d-ba52-afb6490a86e0', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 21:54:09.228348+00', ''),
	('00000000-0000-0000-0000-000000000000', '3879387f-eede-4835-8b11-cecbd6780f2f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 22:53:42.365286+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e2a47932-a702-4866-b9c0-0f623389ac17', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-26 22:53:42.366541+00', ''),
	('00000000-0000-0000-0000-000000000000', '076c86c1-3d07-4e90-b284-580294e3b845', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 15:00:19.839978+00', ''),
	('00000000-0000-0000-0000-000000000000', '41573b05-cf5f-4d5c-9858-68d5ee377a11', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 15:00:19.842244+00', ''),
	('00000000-0000-0000-0000-000000000000', '1f4615c7-8b37-46cb-bdde-c887ae030c70', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 16:00:32.061745+00', ''),
	('00000000-0000-0000-0000-000000000000', '681e4a35-533b-4e61-a2a7-79ad9a3f8503', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 16:00:32.064191+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b06a638b-c173-4aa0-8334-085fc9bea29b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 17:18:05.667118+00', ''),
	('00000000-0000-0000-0000-000000000000', '8e0ef8ba-f57e-4efd-814d-0a111cc7b6b2', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 17:18:05.670219+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd173cd48-dbdd-441f-a1ae-81b0cb31a9fe', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 18:27:52.808227+00', ''),
	('00000000-0000-0000-0000-000000000000', 'db105fff-a54f-4fc2-aa7e-237ce2b1cfb4', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 18:27:52.80981+00', ''),
	('00000000-0000-0000-0000-000000000000', '38c7f069-2669-4cae-9a09-05614cf30f5b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 19:53:31.537197+00', ''),
	('00000000-0000-0000-0000-000000000000', '16a0b6f9-bff6-4a46-85f6-bef190ac4e47', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 19:53:31.539852+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a83a6192-7262-47ec-8eda-793dec09b8ea', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 20:55:08.690125+00', ''),
	('00000000-0000-0000-0000-000000000000', '7efb0faf-009c-4607-813d-9427cb17aaa0', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 20:55:08.692113+00', ''),
	('00000000-0000-0000-0000-000000000000', '66e96d92-9d77-4e19-ba6d-655245904037', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-27 21:01:55.824258+00', ''),
	('00000000-0000-0000-0000-000000000000', '516fec3c-84c2-41fe-bca9-5f49dec223b5', '{"action":"token_refreshed","actor_id":"40db71eb-68d2-402a-ae3f-6bd099418409","actor_username":"distributor@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 21:07:56.867015+00', ''),
	('00000000-0000-0000-0000-000000000000', '819ecbcf-fbb3-4c6b-a785-28f2f5906459', '{"action":"token_revoked","actor_id":"40db71eb-68d2-402a-ae3f-6bd099418409","actor_username":"distributor@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 21:07:56.867608+00', ''),
	('00000000-0000-0000-0000-000000000000', '870a8801-54af-42a4-b576-008d1c4870f2', '{"action":"logout","actor_id":"40db71eb-68d2-402a-ae3f-6bd099418409","actor_username":"distributor@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-03-27 21:07:57.00269+00', ''),
	('00000000-0000-0000-0000-000000000000', '4087e99e-d0d2-4259-9c6a-adab68c927f9', '{"action":"login","actor_id":"3bc9b49e-448d-45e1-8316-76bc063948db","actor_username":"group@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-03-27 21:08:01.082539+00', ''),
	('00000000-0000-0000-0000-000000000000', '34d5d0d6-d3e4-44c8-90a3-32b1f19e64d8', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 21:57:00.852935+00', ''),
	('00000000-0000-0000-0000-000000000000', '8dab20b1-e0c2-4d58-a061-695602e4d109', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 21:57:00.854682+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f6172dd5-06ab-4614-b420-57d43faa80d8', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 23:03:12.47626+00', ''),
	('00000000-0000-0000-0000-000000000000', '5f8dc84b-54b8-47bf-ab31-6c4fa3a78cf7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-03-27 23:03:12.477618+00', ''),
	('00000000-0000-0000-0000-000000000000', '76ed9e15-286b-4bcf-992c-ea18c2f29f4c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 15:53:30.212401+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f7aea958-5e8c-4e9c-9ffb-194b6703fab7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 15:53:30.219403+00', ''),
	('00000000-0000-0000-0000-000000000000', '64afbebc-42b4-428e-87c8-4d99572a3d61', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-08 15:53:30.574915+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd9945f73-03d6-49e9-8c4c-3cb99226dcea', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-08 15:53:32.187813+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e5f727c5-7c8b-40b7-b4d3-d4b723f6390c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 17:11:02.411802+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c1746f0d-6fb2-4a9d-b79c-5c0e868193a2', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 17:11:02.414085+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b00a1d85-7295-4bea-a1c3-f79319941d30', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 17:53:44.637097+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f4ee8b2a-0d3c-4359-9d7c-906e3417f5e6', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 17:53:44.682724+00', ''),
	('00000000-0000-0000-0000-000000000000', '9173a745-c9e7-46bf-bd4a-3e09e06b7fcc', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-08 17:53:44.827964+00', ''),
	('00000000-0000-0000-0000-000000000000', '7714438e-c8ef-48b1-a1c0-31bc6c853a22', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-08 17:53:46.717952+00', ''),
	('00000000-0000-0000-0000-000000000000', '1dbd0d05-5071-4ab8-b946-6dad1d44f29c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 20:30:48.616788+00', ''),
	('00000000-0000-0000-0000-000000000000', '472f2cfd-c380-4d34-992a-dfd21af6f45b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 20:30:48.618497+00', ''),
	('00000000-0000-0000-0000-000000000000', '62e64ddb-d2b5-4adf-9277-3546b726f6cf', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 21:30:31.35466+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e8e795d3-43ba-445c-a495-0ece4c42f1d0', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 21:30:31.357176+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ea242a9d-70f1-4c26-ae72-063a27850d52', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-08 21:47:02.49942+00', ''),
	('00000000-0000-0000-0000-000000000000', '6103bd96-1bfc-4641-a11a-034b0850c3f2', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 22:28:43.77543+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd219ac6a-bfb4-4ca0-b4fc-df5cb0724dd1', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 22:28:43.778165+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ad7514a7-cff2-4d80-8ec2-4a9a78fbb308', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-08 23:12:37.928006+00', ''),
	('00000000-0000-0000-0000-000000000000', '57586fe9-9a39-4ba0-8e7c-e260c008326d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 23:20:43.259625+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a8734c8a-e51c-4d3e-9689-9d96e6a8c168', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-08 23:20:43.26151+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd00060dd-582d-44e9-9330-3adc9a6c4913', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 15:08:47.262467+00', ''),
	('00000000-0000-0000-0000-000000000000', '700e6e75-80e2-4ca4-a6de-67043f431aa0', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 15:08:47.265267+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cb33303a-b491-43fb-b6e7-7cf617fb0122', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 15:08:47.395967+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c2cdce54-ceb5-41b4-aa86-106b5fac64e3', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-09 15:08:47.50784+00', ''),
	('00000000-0000-0000-0000-000000000000', '608cf02d-c85d-4afe-8cc5-af156fe806e3', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-09 15:09:57.2827+00', ''),
	('00000000-0000-0000-0000-000000000000', '2deece22-d25e-4907-acd7-fb7d0c218cda', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 18:07:38.363654+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f24127e7-33aa-436b-a591-202251f546e7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 18:07:38.365063+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bec0fdd7-2f94-475d-aa2b-2f99e364c5ee', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 19:45:49.663981+00', ''),
	('00000000-0000-0000-0000-000000000000', '643d4693-4ad0-46d0-a735-a914bb9b84bf', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 19:45:49.667094+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd2b7c410-5938-48be-bc70-36d8552b6b46', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 20:43:55.318495+00', ''),
	('00000000-0000-0000-0000-000000000000', '88cbcbea-3210-4de8-b1f3-0927fc28876e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 20:43:55.320114+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd4d7d392-22f8-4c49-9c69-7b939db17166', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-09 20:57:43.960427+00', ''),
	('00000000-0000-0000-0000-000000000000', '868d9fc5-ace5-4950-8ab7-95590df0785f', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"jesus@theoutdoorplus.com","user_id":"67b8a91a-f30f-4bde-90a1-7a632e250809","user_phone":""}}', '2024-04-09 20:58:28.62951+00', ''),
	('00000000-0000-0000-0000-000000000000', '75ab6ccc-1999-4594-a8d9-0fe0648c6ec0', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-09 20:59:01.87814+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f19301b6-53df-4e82-aa9f-b8b5d9c31874', '{"action":"login","actor_id":"67b8a91a-f30f-4bde-90a1-7a632e250809","actor_username":"jesus@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-09 20:59:52.653198+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c48cb6f8-41d6-4d68-bdfd-8ff97ec3c5bd', '{"action":"logout","actor_id":"67b8a91a-f30f-4bde-90a1-7a632e250809","actor_username":"jesus@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-09 20:59:54.858432+00', ''),
	('00000000-0000-0000-0000-000000000000', '4706acc5-f468-4299-877c-1d739ee8056b', '{"action":"login","actor_id":"67b8a91a-f30f-4bde-90a1-7a632e250809","actor_username":"jesus@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-09 21:07:40.302026+00', ''),
	('00000000-0000-0000-0000-000000000000', '4fd5445c-b1ae-499b-8544-2ec9028a9fe7', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-09 21:43:46.078501+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ff29b34c-c55e-44e7-bfb4-5ff0de1c77f4', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 22:41:57.805934+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d8ebcaf-5e65-473d-bb05-5b5defa86aaa', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 22:41:57.808334+00', ''),
	('00000000-0000-0000-0000-000000000000', '7669ec48-2ee9-49e4-aa0e-f90315d90b75', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 23:40:07.426683+00', ''),
	('00000000-0000-0000-0000-000000000000', '867c335b-2759-4600-b147-5f52de93123b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-09 23:40:07.430116+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bdb30900-ba87-470e-ac12-c1f9d2e69b0e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 15:25:51.338669+00', ''),
	('00000000-0000-0000-0000-000000000000', '59ca7fb7-9629-442b-8a52-26a765e33318', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 15:25:51.343236+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f695dc4b-6534-431e-88df-efa45988baf6', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 15:25:51.503061+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eb158ad3-e652-4e14-9ddd-c0291950aa17', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 15:25:54.96137+00', ''),
	('00000000-0000-0000-0000-000000000000', '6ec76ad2-295b-4098-8a9d-c02c349dcba7', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 15:25:57.662804+00', ''),
	('00000000-0000-0000-0000-000000000000', '64f8a005-e2bf-4692-803e-f3503c8d7cf1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 16:24:09.962939+00', ''),
	('00000000-0000-0000-0000-000000000000', '4ea8585e-5e16-4651-a4ad-6bd3d58377f6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 16:24:09.966618+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f6bd28af-6755-4977-9360-2e10cc1aa0d0', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"dealer@topdashboard.com","user_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","user_phone":""}}', '2024-04-10 17:00:26.409842+00', ''),
	('00000000-0000-0000-0000-000000000000', '78693280-dc4f-483a-8d06-d5868240e824', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 17:00:36.11179+00', ''),
	('00000000-0000-0000-0000-000000000000', '6682ee35-23a0-4c90-8489-3a0ca8f123d3', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 17:00:46.293833+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b81de6d7-e3f1-4aef-8b22-53d1feab2252', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 17:59:08.76484+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b8423807-7386-4422-8849-13da2b69fd62', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 17:59:08.766869+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd3062c95-f210-4615-bf94-73b466d21e89', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 18:01:21.345793+00', ''),
	('00000000-0000-0000-0000-000000000000', '15fe0ae1-e6dd-456f-9236-0c0ca3cd5657', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 18:01:33.400332+00', ''),
	('00000000-0000-0000-0000-000000000000', '16a003b0-510a-4179-888a-690c4a879ae9', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 18:07:07.875833+00', ''),
	('00000000-0000-0000-0000-000000000000', '6725a10a-bd69-4e49-82eb-166fe958df66', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 18:07:11.565562+00', ''),
	('00000000-0000-0000-0000-000000000000', '7eb2f975-3f00-4cd4-90c2-05e7c1615baf', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 18:09:10.209366+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a0c7d021-24f1-41ac-84c4-dda1d4d62bbe', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 18:09:13.970019+00', ''),
	('00000000-0000-0000-0000-000000000000', '4732b62c-710c-4b2b-a98f-ea7cb0ddf40c', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 18:14:07.491585+00', ''),
	('00000000-0000-0000-0000-000000000000', '5762a50e-5c64-4895-9dd6-6d2c1bc96a58', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 18:14:10.807697+00', ''),
	('00000000-0000-0000-0000-000000000000', '0f68b945-42d7-416a-bfde-5554d451c63d', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 18:38:01.810092+00', ''),
	('00000000-0000-0000-0000-000000000000', '27a39372-28fa-441f-9590-1bf6da9dbf86', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 18:38:04.231681+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f0064c90-63cc-4833-8c82-35b1bf28689b', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 18:38:07.332024+00', ''),
	('00000000-0000-0000-0000-000000000000', '993aa78c-8c7f-4a6e-8d0e-073fa76239f7', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 18:38:10.787348+00', ''),
	('00000000-0000-0000-0000-000000000000', 'da8f8358-cef5-469e-a965-9d308d50d552', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 20:00:43.358304+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b3ae8c3-154b-4b75-ad2b-97bf7b74e226', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 20:00:43.361112+00', ''),
	('00000000-0000-0000-0000-000000000000', '2e6607c9-7717-4b72-88ee-f53b2730ac7c', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 21:00:23.589773+00', ''),
	('00000000-0000-0000-0000-000000000000', '7556e2c8-e562-4b5f-92b4-f6084fe8bd1b', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 21:00:26.73457+00', ''),
	('00000000-0000-0000-0000-000000000000', '90bd1fc5-8cd3-4fbd-89e1-1e99cbc57cd9', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 21:01:13.564708+00', ''),
	('00000000-0000-0000-0000-000000000000', '38a0f164-f407-49bb-84ed-4ee5821b53c3', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 21:01:16.647222+00', ''),
	('00000000-0000-0000-0000-000000000000', '9213d003-2e88-4ab6-8850-d42197114f59', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 22:11:05.683853+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cea53ce3-5662-4f04-b4c3-1cb9638b3cbc', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-10 22:11:05.685891+00', ''),
	('00000000-0000-0000-0000-000000000000', '34a1c1e1-222b-451a-9128-e47a75f9d4c8', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-10 23:03:12.568589+00', ''),
	('00000000-0000-0000-0000-000000000000', '617d8f8a-f4f3-45d0-b0d1-4ae708a5272f', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-10 23:40:06.790463+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c15d2686-3950-4a5c-a942-ecf3c52301cd', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 15:10:02.998495+00', ''),
	('00000000-0000-0000-0000-000000000000', '21b29782-1644-4e42-b66f-e73bc4f5e87e', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 15:10:03.003435+00', ''),
	('00000000-0000-0000-0000-000000000000', '627dbde6-0188-4a1b-a171-e5b87075940d', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 15:10:03.16664+00', ''),
	('00000000-0000-0000-0000-000000000000', '9b38bf5c-cbd4-4625-af6c-a8c7ddaaa654', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 15:10:06.256495+00', ''),
	('00000000-0000-0000-0000-000000000000', '83b3a0c5-a0f9-4b67-b85b-f9db53031613', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 15:10:08.805553+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ecb3cb2e-4de8-44a3-a21d-37b287d33776', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 15:10:13.346017+00', ''),
	('00000000-0000-0000-0000-000000000000', '437a72a8-9611-4e02-9e6e-e3fc7ce8b7be', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 15:10:17.782286+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dbfc3f13-26ce-4367-8640-1268ba65ac05', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 16:12:59.599818+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd92fd2dc-e0c5-424a-9481-7c94620629f8', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 16:12:59.601854+00', ''),
	('00000000-0000-0000-0000-000000000000', '7eb9655f-23fc-44f6-84c8-26b6a4847e39', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 17:13:10.16751+00', ''),
	('00000000-0000-0000-0000-000000000000', '2aa81f6d-a17c-461d-8ade-cef227a27c4a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 17:13:10.168947+00', ''),
	('00000000-0000-0000-0000-000000000000', 'af51b894-f3fd-4638-8e55-8cd563990eff', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 17:13:10.482255+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bff49e7a-a1c8-498c-bffc-d635642ce50e', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 17:14:03.624009+00', ''),
	('00000000-0000-0000-0000-000000000000', '6706b768-7950-4328-af6d-28a872eab59b', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 18:21:02.651197+00', ''),
	('00000000-0000-0000-0000-000000000000', '0b3687ee-6455-4e0d-9af1-3221ff49bd2e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 18:21:02.652731+00', ''),
	('00000000-0000-0000-0000-000000000000', '130a6553-1da2-4fb2-aa2f-3628d8ec6d51', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 18:33:46.112963+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ecb8a496-37c4-43b2-b561-9bbdc52874d5', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 18:33:49.823755+00', ''),
	('00000000-0000-0000-0000-000000000000', '643536db-0d7a-45c7-8650-42ff441968c7', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 18:40:07.250925+00', ''),
	('00000000-0000-0000-0000-000000000000', '97316eb4-d781-408e-8bf5-e9676a6d96c1', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 18:40:09.195773+00', ''),
	('00000000-0000-0000-0000-000000000000', 'daa47306-c16f-44a4-8d6b-9328e1a6c4bb', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 18:40:12.329598+00', ''),
	('00000000-0000-0000-0000-000000000000', 'be38efdf-ba48-40e9-a926-687bf5007651', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 18:40:15.828965+00', ''),
	('00000000-0000-0000-0000-000000000000', '99e3f12c-6025-49b6-ac44-395a09e2aa4e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 20:04:24.410553+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e0449af-f0c9-42d8-b122-281cf111a103', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 20:04:24.412024+00', ''),
	('00000000-0000-0000-0000-000000000000', '7433e4c7-1438-49ad-94a5-f727bcaa39d6', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 20:04:24.574114+00', ''),
	('00000000-0000-0000-0000-000000000000', '7bd3a8e9-933c-4cea-a7c4-495a4a893d0f', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 20:04:27.157843+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ea3bc32a-bc9a-45a8-bff6-d39c762d96d0', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 21:01:23.005112+00', ''),
	('00000000-0000-0000-0000-000000000000', 'acf50bcb-18ef-4884-9adf-670f77ed2e34', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 21:01:25.512705+00', ''),
	('00000000-0000-0000-0000-000000000000', '35beeba7-6f98-40eb-9b17-916165d0ba04', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 21:13:45.273271+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ce726aa1-6b21-4d7d-9558-90f700e03a15', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 21:13:48.687986+00', ''),
	('00000000-0000-0000-0000-000000000000', '87b8327c-0294-4741-9bbd-d6cd00bfc2f1', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-11 22:03:44.60059+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f40b9e45-d3b7-495c-8c84-df79985eee75', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 22:33:38.905681+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ff6b3324-b34c-4927-93e3-499ad37abba2', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 23:16:00.007591+00', ''),
	('00000000-0000-0000-0000-000000000000', '5732460b-fc87-48fd-a31a-b55606f97757', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 23:34:49.667856+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b98e0567-25ab-4ef9-92c4-2483851729b5', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-11 23:34:49.670288+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc4dc2f0-9b53-43b9-8011-62cd6c937c0c', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 23:44:14.945167+00', ''),
	('00000000-0000-0000-0000-000000000000', '3c3ad727-b55f-49b7-8c1e-240d83549e34', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-11 23:47:16.90479+00', ''),
	('00000000-0000-0000-0000-000000000000', '338c9c7f-e0f7-4bda-b96d-0e602755af3e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 15:48:17.069703+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e84e9144-4ded-4caf-8630-42d1865ef761', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 15:48:17.071004+00', ''),
	('00000000-0000-0000-0000-000000000000', '2c570b33-a32d-4e3d-9d8f-796ecedd93b2', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 15:48:17.211236+00', ''),
	('00000000-0000-0000-0000-000000000000', '43664e39-639d-40ee-8f71-1470fc0982ec', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-12 15:48:23.259764+00', ''),
	('00000000-0000-0000-0000-000000000000', '59fde441-ede7-487b-85fb-9152590bc665', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 16:00:58.135881+00', ''),
	('00000000-0000-0000-0000-000000000000', '989182fb-db04-4614-97d5-8cabb55854c1', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 16:00:58.137204+00', ''),
	('00000000-0000-0000-0000-000000000000', '58e8bbba-5e7d-4899-a9c1-e89e66ca260a', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 16:00:58.270686+00', ''),
	('00000000-0000-0000-0000-000000000000', '7ffab33c-c3ac-4636-b492-1a3b6d5803fa', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-12 16:01:38.697395+00', ''),
	('00000000-0000-0000-0000-000000000000', 'edc61340-02c4-4d3a-b6ed-29e48a18c4af', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 16:06:53.181479+00', ''),
	('00000000-0000-0000-0000-000000000000', '507d9724-2871-4038-991b-284da0343f07', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-12 16:07:02.145899+00', ''),
	('00000000-0000-0000-0000-000000000000', '83a68a6b-783b-412a-8a68-0e4888d8e790', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 17:30:25.96167+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cf6fba4b-de42-49ba-8b2f-f35075b2cee1', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 17:30:25.962392+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b4ab3a8c-ca13-4b09-a2ce-156309d5a02a', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 17:30:26.758784+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c9cda0ce-afbf-4622-9f0f-ab4b416b7394', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-12 17:30:48.480791+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dcb1a0a7-73f1-407e-9af1-7498b969adf0', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 17:31:16.150655+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b38c3f2-c5ee-48fb-aa28-b1b7cf5d5ac2', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-12 17:31:19.685102+00', ''),
	('00000000-0000-0000-0000-000000000000', '037f995c-954d-4b32-bc83-cfd7874b464a', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-12 18:15:34.366228+00', ''),
	('00000000-0000-0000-0000-000000000000', '87a47938-e655-45ad-aace-dad67339f513', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 19:49:59.33632+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c48d332c-aa91-4295-ae2d-9812e1e6b502', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 19:49:59.33841+00', ''),
	('00000000-0000-0000-0000-000000000000', '96d189bf-c23d-4c02-8b78-ee0a4651a2bd', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 19:50:00.965989+00', ''),
	('00000000-0000-0000-0000-000000000000', '999561d3-37a2-4eba-b8e7-58df527525eb', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 20:25:40.399189+00', ''),
	('00000000-0000-0000-0000-000000000000', '4e780de1-d1dc-428b-865a-ca39ff11c7c2', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 20:25:40.39979+00', ''),
	('00000000-0000-0000-0000-000000000000', '26ccdb16-413e-41b2-8924-26a39978bd0d', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 20:25:46.731584+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f5762e3a-f7fc-4b6c-b342-f8a8defbbe18', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-12 20:25:50.504749+00', ''),
	('00000000-0000-0000-0000-000000000000', '52b4d300-3c29-44a0-beb6-189e0bac8058', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 21:54:37.651059+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd569e4d5-b7a5-4259-acf6-d98dbf913a02', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 21:54:37.652285+00', ''),
	('00000000-0000-0000-0000-000000000000', '360d8905-7908-454f-b86d-abab09ff6f82', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 23:04:26.245566+00', ''),
	('00000000-0000-0000-0000-000000000000', '44f7573a-e5b9-43e0-8ab0-f6c41bf6c577', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-12 23:04:26.246688+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bcf03e29-50f3-48fa-8c77-1eda3dd83659', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-12 23:04:26.389838+00', ''),
	('00000000-0000-0000-0000-000000000000', '96b64c1c-dfa3-4f7f-9002-febd031d745e', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 15:44:25.101543+00', ''),
	('00000000-0000-0000-0000-000000000000', '0c209062-45b9-486f-8b49-22fec2bff7b1', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 16:47:04.451367+00', ''),
	('00000000-0000-0000-0000-000000000000', '0f43ed00-3b47-4410-9aa1-15acb3e91b8a', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 16:47:04.455169+00', ''),
	('00000000-0000-0000-0000-000000000000', '30da55af-1907-4adf-8017-68bb74d2b8fa', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 17:36:16.575543+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ebefc5c6-8c92-4a7a-978e-25999bd7d12c', '{"action":"login","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 17:42:32.026883+00', ''),
	('00000000-0000-0000-0000-000000000000', '94a96570-9610-4b42-9da0-c14b4fb7a069', '{"action":"logout","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-15 17:54:49.785199+00', ''),
	('00000000-0000-0000-0000-000000000000', '4c40ab9a-e3a0-4591-9eac-f89eb15a2e4d', '{"action":"login","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 17:56:34.490383+00', ''),
	('00000000-0000-0000-0000-000000000000', '3e912b3c-b8aa-499f-9a65-632fcdebcaf7', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 18:44:47.698304+00', ''),
	('00000000-0000-0000-0000-000000000000', '3c59c2f4-750d-4335-9078-69a46220b8bf', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 18:44:47.698918+00', ''),
	('00000000-0000-0000-0000-000000000000', '7aed1ea5-4772-44c8-bde9-f1bb47913bf6', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 19:48:55.001203+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b120a8eb-51d2-4e22-8647-36cf5593cfaf', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 19:48:55.003991+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fa938934-ceb8-4f31-b696-12ed2fe71411', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 20:52:54.979954+00', ''),
	('00000000-0000-0000-0000-000000000000', '8787a110-a63f-4181-9fb0-ad0241023fdb', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 20:52:54.9828+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b9a6b493-b155-4a01-87ef-06f3de4b748c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 21:03:55.214922+00', ''),
	('00000000-0000-0000-0000-000000000000', '16078c11-bbf5-44af-9b43-118bf8fc5136', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 21:03:55.217353+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dbb34701-31b8-4d71-ba67-b3bb6aa4e623', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 21:51:12.016111+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e0104447-af10-4eae-af4c-1b2d2cc06a1b', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-15 21:51:12.017687+00', ''),
	('00000000-0000-0000-0000-000000000000', '0e014217-5049-45ae-8465-d2c782ea4d20', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"dealer@topdashboard.com","user_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","user_phone":""}}', '2024-04-15 22:27:06.456849+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e580eaec-3d93-417e-a4ec-6084307ea368', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"dealer@topdashboard.com","user_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","user_phone":""}}', '2024-04-15 22:28:14.540117+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bccb7b5c-0662-4efc-b050-f78a75f7dc6d', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"dealer@topdashboard.com","user_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","user_phone":""}}', '2024-04-15 22:30:12.466161+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e35bd7df-9eae-432e-8749-0bb85b06e769', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"dealer@topdashboard.com","user_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","user_phone":""}}', '2024-04-15 22:30:23.754965+00', ''),
	('00000000-0000-0000-0000-000000000000', '7007b46c-d013-4f3c-a1c7-667562dc0367', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"distributor@topdashboard.com","user_id":"40db71eb-68d2-402a-ae3f-6bd099418409","user_phone":""}}', '2024-04-15 22:32:01.397679+00', ''),
	('00000000-0000-0000-0000-000000000000', '8380005b-00fb-439f-915a-dc573bc5b297', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-15 22:36:37.313162+00', ''),
	('00000000-0000-0000-0000-000000000000', '984ead4d-6165-4251-acaa-11ec0c347115', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 22:36:42.304257+00', ''),
	('00000000-0000-0000-0000-000000000000', '63aa7612-7016-49cb-a633-8988a8861aa4', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-15 22:43:56.111142+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ae919516-d417-4852-811a-929a08a900b8', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 22:43:59.93357+00', ''),
	('00000000-0000-0000-0000-000000000000', '70df751c-0f8c-488a-ab05-040e3a1551f6', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-15 23:20:01.583383+00', ''),
	('00000000-0000-0000-0000-000000000000', '40176425-eb46-43c1-a05a-2ddbc836f615', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 23:20:06.327645+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a40b7356-e482-4de7-9c8f-19116b744f60', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-15 23:26:24.635382+00', ''),
	('00000000-0000-0000-0000-000000000000', '9e5abc37-bbef-4a4b-93cf-3bb898badc5f', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 23:26:27.064008+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b8557e8d-b2e2-4bf6-957a-527db07326cf', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-15 23:26:31.257088+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ed339f9a-2ce4-44e7-b37c-8cedb6474f38', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 23:26:34.523656+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e4162772-9c87-4aa8-980b-874146df87e2', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-15 23:56:03.14321+00', ''),
	('00000000-0000-0000-0000-000000000000', '6486b498-3e30-4233-99d9-e5db0ba11474', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-15 23:56:13.974146+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e214bc5c-9339-45c6-a79a-df68b85c6032', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 00:03:23.875413+00', ''),
	('00000000-0000-0000-0000-000000000000', '8d0f6cea-dfa3-4d00-8cb6-56b7d2502c6e', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 00:03:28.190185+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fe4e6720-0148-484e-8245-0d4bd0bb12ab', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 00:03:37.460349+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ee6bc502-8893-4f75-95ac-e780ca0316e5', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 00:03:41.547963+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a22471b4-4a6d-40fc-8571-7f2c2610d056', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 15:25:10.227183+00', ''),
	('00000000-0000-0000-0000-000000000000', '8e2ee963-2e7a-4956-acc2-a8de074b034a', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 15:25:10.230332+00', ''),
	('00000000-0000-0000-0000-000000000000', '3d81bb1a-f124-4660-bac5-40a97f055a3c', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 15:25:10.600552+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c9404456-41b1-4b81-8089-446ac4fdc99a', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 15:30:17.595105+00', ''),
	('00000000-0000-0000-0000-000000000000', '2b002c81-bc1b-4661-b6b1-b38667235ff0', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 15:34:41.647492+00', ''),
	('00000000-0000-0000-0000-000000000000', '88141ccf-97a5-4c5c-acfb-7fd02d4066b5', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 15:34:50.058421+00', ''),
	('00000000-0000-0000-0000-000000000000', '13577dc7-3225-4669-b037-2b70e3af83e7', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 15:34:53.55238+00', ''),
	('00000000-0000-0000-0000-000000000000', '97713e6d-cb71-4450-866b-3d2d69f26e18', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 18:01:25.162898+00', ''),
	('00000000-0000-0000-0000-000000000000', '53a20b92-0fb2-4ee7-b831-f0348ad64b15', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 18:01:25.164509+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dd38ca76-e529-47c5-a04f-b4ec69a36c75', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 18:01:25.492423+00', ''),
	('00000000-0000-0000-0000-000000000000', '1303dd28-19a2-436f-99c5-4866c50123ce', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 18:01:32.581836+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5cc10ac-b5f7-4249-9d9e-59a74ba399ef', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 18:02:04.973834+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f7a4a52d-6d7d-41d3-bac5-265266f3da08', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 18:02:09.677389+00', ''),
	('00000000-0000-0000-0000-000000000000', '288d202c-a805-44da-8d50-e32ab5453637', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 18:06:54.325799+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b503c944-a836-471b-aafe-42fce8ff103e', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 18:08:29.326264+00', ''),
	('00000000-0000-0000-0000-000000000000', '2b38c324-60e7-4e75-89d8-193c9fe39a21', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 18:08:41.987423+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f6377b8c-a713-42d1-aa09-2f64761d7d89', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 18:08:43.936922+00', ''),
	('00000000-0000-0000-0000-000000000000', '9599b974-3cec-40b5-a719-bca1d8ab191d', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 18:09:16.141716+00', ''),
	('00000000-0000-0000-0000-000000000000', '54ae9eeb-9245-4603-88a4-e7f2d413d742', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 18:09:17.974994+00', ''),
	('00000000-0000-0000-0000-000000000000', '4554f617-a441-40ef-b0c0-a0465dad5e10', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 19:07:46.978754+00', ''),
	('00000000-0000-0000-0000-000000000000', '3dc44d45-176a-46f7-a3f7-8d6bee57d660', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 19:07:46.980935+00', ''),
	('00000000-0000-0000-0000-000000000000', '601dd2e4-3c7d-493c-a5e6-6bab3a1c0323', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 19:52:08.652625+00', ''),
	('00000000-0000-0000-0000-000000000000', '4f5fc85d-62f8-47a4-bd70-2db803343b2d', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 20:51:46.613242+00', ''),
	('00000000-0000-0000-0000-000000000000', '1c02e29b-3486-457f-85c7-57e829d0ad0e', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 20:53:32.890107+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc6d05b1-c952-49db-aee7-de5e38b5f270', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 20:53:32.892413+00', ''),
	('00000000-0000-0000-0000-000000000000', '0ad3f231-1872-4e4c-9b29-2ad79b3eed7a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 21:49:56.364745+00', ''),
	('00000000-0000-0000-0000-000000000000', '42705560-5304-40ce-bc0e-dc80b4139508', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 21:49:56.367582+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c328c703-359b-4f77-a226-5f569686119a', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 22:06:14.716648+00', ''),
	('00000000-0000-0000-0000-000000000000', '364663ee-06b1-4410-bc64-4a091f10168c', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 22:06:14.719243+00', ''),
	('00000000-0000-0000-0000-000000000000', '796c60f4-a968-4734-b5a0-db376553e241', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 22:15:09.349419+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c52b7d96-aa8e-44d8-b9e3-a7f432a439da', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 22:15:09.351149+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cbb03e93-03ef-4e95-b04b-968ce3a0a0c8', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 22:47:58.132826+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e621dc33-f9bd-4324-9d72-78e3653a0a4d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 22:47:58.135397+00', ''),
	('00000000-0000-0000-0000-000000000000', '089bada7-ef57-4780-b2f7-30b6e57473ff', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 23:30:33.768188+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ff93c461-b15a-47a3-8121-0ff6f51afb2d', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-16 23:30:33.769949+00', ''),
	('00000000-0000-0000-0000-000000000000', '67993a2f-6b96-40b9-ae21-46392b169df5', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 23:30:34.13607+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ad1e4297-ba03-4808-b734-cbec9255ffd5', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 23:30:35.510104+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f508f001-7b0f-40a0-bfeb-d9b8f4dae18b', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 23:35:55.471573+00', ''),
	('00000000-0000-0000-0000-000000000000', '55ebf0b8-6977-46ce-b147-7ba2677d962f', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 23:35:57.690173+00', ''),
	('00000000-0000-0000-0000-000000000000', 'af878839-b058-451a-bb78-948e6d6f7f73', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-16 23:35:59.281598+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f240b466-83b3-4667-8bd2-42f15fcace84', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-16 23:36:02.436305+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f3c3f55-f803-40d4-986b-df645884f488', '{"action":"token_refreshed","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 15:03:50.057484+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ecdb5f54-ec0a-4ba5-8a41-9f4eedc4a85e', '{"action":"token_revoked","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 15:03:50.059638+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fa5916c8-d7af-43c3-95c8-e0963b47e5c1', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-17 15:14:17.410655+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ff6537c7-43fd-488d-8a4b-1c523672852d', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-17 15:14:21.303456+00', ''),
	('00000000-0000-0000-0000-000000000000', '2a8084f0-0a43-47ee-958e-1a4d13491a1f', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 16:39:47.298499+00', ''),
	('00000000-0000-0000-0000-000000000000', '7afd0c19-6e82-48dd-94b3-6267601e0e26', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 16:39:47.301077+00', ''),
	('00000000-0000-0000-0000-000000000000', '71877c46-f779-4fb3-bc68-8319bb908338', '{"action":"login","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-17 17:19:55.700071+00', ''),
	('00000000-0000-0000-0000-000000000000', '654ce775-4ca6-4b59-ab43-0dbc2942c4fa', '{"action":"logout","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-17 18:00:04.766093+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd809bc6d-604a-4c65-b903-5a10140933a3', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 18:08:45.413426+00', ''),
	('00000000-0000-0000-0000-000000000000', '7e127a5c-d434-4142-9ce5-891ffcf2b8a6', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 18:08:45.416228+00', ''),
	('00000000-0000-0000-0000-000000000000', '4df07f2a-013c-4255-98b1-a590ea9713d9', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-17 18:08:46.119928+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c700ca1d-36f1-4b0d-94e1-0e5574a4c3ce', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-17 18:08:49.955909+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bf54a123-b292-4590-a283-3339eef44ecc', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-17 23:02:54.983118+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b832326f-2e75-4183-a510-92bbf3ce8146', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 23:05:53.378586+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eaa5f49e-57a0-4157-b205-0927013c7251', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-17 23:05:53.381323+00', ''),
	('00000000-0000-0000-0000-000000000000', '7e858ba9-e5de-42cc-9d50-7fcaad5a1a2e', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-17 23:05:53.507057+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b381cfa-8958-4ecf-92bc-a4faaea0dbc6', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-17 23:05:55.087111+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b7600d15-039f-4b90-9a1b-2e3e57ea7e80', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"liz@theoutdoorplus.com","user_id":"44badead-159b-41b6-b746-3f3018620544","user_phone":""}}', '2024-04-17 23:20:15.778591+00', ''),
	('00000000-0000-0000-0000-000000000000', '1108e1e7-464b-485c-91c2-65ff0b5c9c34', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"0c823f1a-5f93-4ccc-97bb-dbee397f2cee","user_phone":""}}', '2024-04-17 23:25:28.848958+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ce883902-e52a-468d-871a-6852e903715a', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"0c823f1a-5f93-4ccc-97bb-dbee397f2cee","user_phone":""}}', '2024-04-17 23:29:00.576107+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ecaa69b5-4144-406d-8631-877a287c90a2', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"dfadf918-85d8-46df-af9b-601aa7e1e4e3","user_phone":""}}', '2024-04-17 23:29:08.836706+00', ''),
	('00000000-0000-0000-0000-000000000000', '46936043-cdd5-47a1-9a4b-e62bbed0dc9c', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test2@test.com","user_id":"0ac1cff9-3281-43e9-ab4d-e325a8d6e283","user_phone":""}}', '2024-04-17 23:31:26.378201+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bfa5bb05-b1a0-423d-ab34-db286def2988', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test2@test.com","user_id":"0ac1cff9-3281-43e9-ab4d-e325a8d6e283","user_phone":""}}', '2024-04-17 23:31:30.852739+00', ''),
	('00000000-0000-0000-0000-000000000000', '99d07c74-5cdc-4d8a-9477-5bb00b30f379', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"dfadf918-85d8-46df-af9b-601aa7e1e4e3","user_phone":""}}', '2024-04-17 23:31:33.563142+00', ''),
	('00000000-0000-0000-0000-000000000000', '6e578c9e-acbf-425a-a6b0-6973c27ea43d', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"liz@theoutdoorplus.com","user_id":"532f136a-1a45-4ea4-9293-f353a4f13922","user_phone":""}}', '2024-04-17 23:32:02.603119+00', ''),
	('00000000-0000-0000-0000-000000000000', '68913442-d7cc-4eab-852c-c25e615dd343', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 15:29:13.815585+00', ''),
	('00000000-0000-0000-0000-000000000000', '1f3ec318-a2a0-4216-b9ab-06bdcccfcc09', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"liz@theoutdoorplus.com","user_id":"6029384c-bf78-44a3-8cae-de4e07a9bd6c","user_phone":""}}', '2024-04-18 15:30:10.427822+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dc770eaf-ee31-4915-b189-2da5a9a96d2c', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-18 16:07:50.991219+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c512d036-a2be-4251-82e4-3bd9a24b15f7', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-18 16:07:50.993018+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd11834c3-bc5b-43f4-8212-ec1ba236b4ae', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-18 16:07:57.962452+00', ''),
	('00000000-0000-0000-0000-000000000000', '6296a353-af99-4b18-bed4-ee8462760de5', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-18 16:08:28.102101+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f957f318-03de-4439-b6e3-0fe918a41d39', '{"action":"login","actor_id":"6029384c-bf78-44a3-8cae-de4e07a9bd6c","actor_username":"liz@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 16:08:38.061659+00', ''),
	('00000000-0000-0000-0000-000000000000', '824b5e23-d2f5-48fe-8b0d-84000556cd08', '{"action":"logout","actor_id":"6029384c-bf78-44a3-8cae-de4e07a9bd6c","actor_username":"liz@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-18 16:08:43.130684+00', ''),
	('00000000-0000-0000-0000-000000000000', 'caf1a721-33c6-4f3b-95e6-0d34be106543', '{"action":"login","actor_id":"6029384c-bf78-44a3-8cae-de4e07a9bd6c","actor_username":"liz@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 16:14:14.193682+00', ''),
	('00000000-0000-0000-0000-000000000000', '656e0883-8e72-4d05-8477-45639462df94', '{"action":"logout","actor_id":"6029384c-bf78-44a3-8cae-de4e07a9bd6c","actor_username":"liz@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-18 16:21:36.064014+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b44991cd-0c43-495e-938f-fe39d9dd68b8', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 16:21:55.085649+00', ''),
	('00000000-0000-0000-0000-000000000000', '8dc5e78e-d5c1-4b43-a32c-09c2a523ef3b', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 16:36:01.469475+00', ''),
	('00000000-0000-0000-0000-000000000000', '30d7e8c4-1185-4257-a71b-a3b9f637b255', '{"action":"logout","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account"}', '2024-04-18 16:55:28.672212+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc6b6a82-72b9-4ac4-a190-28106edc979c', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 16:55:33.629369+00', ''),
	('00000000-0000-0000-0000-000000000000', '33b799d6-8fbd-4899-97fc-f1f31b745f14', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 18:08:22.78745+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bc554a39-0596-4047-91b8-489f6c3b3f65', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-18 18:14:28.045942+00', ''),
	('00000000-0000-0000-0000-000000000000', '37139774-0acd-46a6-9a21-d811e620c904', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-04-18 18:14:28.050078+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e2d81248-f660-4db0-9ca3-83ccc17d6f9f', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-18 18:14:28.185936+00', ''),
	('00000000-0000-0000-0000-000000000000', '42b475c3-7ad0-4ec8-8575-511f65e4a6e5', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 21:54:39.733252+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d5e67fa-e99f-4898-8d3b-02bd3e72e503', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-18 22:09:23.383637+00', ''),
	('00000000-0000-0000-0000-000000000000', 'aeec6b04-96cf-4b47-9ac1-fafac5b167c6', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 22:09:40.660025+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f533b4a-1020-4465-af33-5b0677d0932c', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 23:12:51.25793+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ee920ae2-bf44-4a0f-b6ce-d27f934367e9', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"joe@theoutdoorplus.com","user_id":"a41f3520-5ffc-4d5f-966e-b3e6bfdccf28","user_phone":""}}', '2024-04-18 23:13:37.4786+00', ''),
	('00000000-0000-0000-0000-000000000000', '3f880387-3ca1-40a7-b9f6-5ebe4c6e9b14', '{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"distributor@topdashboard.com","user_id":"40db71eb-68d2-402a-ae3f-6bd099418409","user_phone":""}}', '2024-04-18 23:29:45.577763+00', ''),
	('00000000-0000-0000-0000-000000000000', '5faefbcc-fb37-4c13-bc05-571537f815f8', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-18 23:39:25.016442+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e0bf2940-6c9f-40c5-ba8d-f32053c82222', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ivan@theoutdoorplus.com","user_id":"6a2f3947-757e-4808-b260-7142b73bef33","user_phone":""}}', '2024-04-18 23:41:39.840291+00', ''),
	('00000000-0000-0000-0000-000000000000', '2472e5de-94e1-47f0-90a5-d89e96236a68', '{"action":"login","actor_id":"6a2f3947-757e-4808-b260-7142b73bef33","actor_username":"ivan@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-19 15:10:54.031646+00', ''),
	('00000000-0000-0000-0000-000000000000', '863dfaff-9752-4b7c-894c-b8e08064fc81', '{"action":"login","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-19 17:27:52.377655+00', ''),
	('00000000-0000-0000-0000-000000000000', '93c947e2-7cc9-463f-9846-aab5617e8767', '{"action":"logout","actor_id":"2e69f583-266e-4ef6-9202-cda8af9a9884","actor_username":"jains@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-04-19 17:29:11.841439+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f5ba08f1-db18-4e59-80d3-12a28cc27926', '{"action":"login","actor_id":"9bd05809-c600-4953-a1d6-b1b9110ba752","actor_username":"dealer@topdashboard.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-04-19 17:29:33.278377+00', ''),
	('00000000-0000-0000-0000-000000000000', '2cedd7b7-957f-4669-9e69-57cecb120e9b', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-05-02 23:19:09.398308+00', ''),
	('00000000-0000-0000-0000-000000000000', '98fb2f4e-a067-4fa5-b6bd-a9a1e03d7833', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-05-03 15:11:53.522084+00', ''),
	('00000000-0000-0000-0000-000000000000', '3d636d1b-83cf-4e13-a7c5-51e5a0be80cb', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-05-03 15:11:53.52772+00', ''),
	('00000000-0000-0000-0000-000000000000', '1549f711-a368-4b78-9fc1-46719888d649', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-05-03 15:11:53.683474+00', ''),
	('00000000-0000-0000-0000-000000000000', '49448ae5-bfcb-4732-abe0-2466943428ae', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-05-03 15:11:53.855431+00', ''),
	('00000000-0000-0000-0000-000000000000', 'accf8af1-1759-4671-859a-5b49aa2db4f4', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-05-03 23:40:02.217592+00', ''),
	('00000000-0000-0000-0000-000000000000', '7dee7999-e39f-4609-ada4-98941955c329', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"8fff38b0-4160-4c31-b2f3-0317b53d97d3","user_phone":""}}', '2024-07-24 15:37:10.877563+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b31492b-648d-435c-80f6-2f390e98a5a2', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-07-30 21:15:29.917577+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f0cea0bd-ce4e-4589-aca8-caef19f0665d', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-08-07 17:13:09.489577+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd739ae60-e1e5-4450-b639-58b1ada7fa3e', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-08-07 17:13:09.494559+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a2beaef7-3611-4d29-864c-17e3700d7abc', '{"action":"logout","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account"}', '2024-08-07 17:13:09.733644+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bf8d7d21-2859-42d7-9443-a94f003b5bf2', '{"action":"login","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2024-08-07 17:13:12.01085+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bfbe209c-8d65-41c9-a5e7-ccf25466a276', '{"action":"token_refreshed","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-08-07 18:11:39.94724+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bad104fd-c9f0-44b9-ad4d-bc0ee973c55c', '{"action":"token_revoked","actor_id":"475d57b8-9842-4a37-be05-2a5527efac99","actor_username":"rodrigo@theoutdoorplus.com","actor_via_sso":false,"log_type":"token"}', '2024-08-07 18:11:39.948519+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'f61ccb8b-5809-4d54-b979-7e39b0398982', 'authenticated', 'authenticated', 'landscape@topdashboard.com', '$2a$10$th76CDL.UYvgyHl5PNzoMuIR1u9xjJQxADMCEnEQu9OGeYonV/pZ2', '2023-10-09 21:39:43.398013+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"role": "LANDSCAPE", "company": "The Outdoor Plus", "last_name": "Account", "first_name": "Landscape"}', NULL, '2023-10-09 21:39:43.394441+00', '2023-10-09 21:39:43.398257+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'f059f4c0-d479-467e-844d-0ba3d7c3a270', 'authenticated', 'authenticated', 'master@topdashboard.com', '$2a$10$c0NW0j2GnjQAYbZN0jSQb.18/.jzKAnsBV/UbfAWXrAxWlrXeibxm', '2023-10-09 21:40:28.730332+00', NULL, '', NULL, '', NULL, '', '', NULL, '2023-10-11 19:25:43.770923+00', '{"provider": "email", "providers": ["email"]}', '{"role": "MASTER_DISTRIBUTOR", "company": "The Outdoor Plus", "last_name": "Account", "first_name": "Master Distributor"}', NULL, '2023-10-09 21:40:28.726756+00', '2023-10-11 19:25:43.773661+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '1a494fcc-4e7c-4541-84f1-70f0a77223bc', 'authenticated', 'authenticated', 'internet@topdashboard.com', '$2a$10$XZMNmR2rafShxxOlPw4p2.LQWIzbTcEit7d1aJaK.Y2Vv42G7f5he', '2023-10-09 21:40:03.229021+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"role": "INTERNET", "company": "The Outdoor Plus", "last_name": "Account", "first_name": "Internet"}', NULL, '2023-10-09 21:40:03.226186+00', '2023-10-09 21:40:03.229249+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'f186c7f3-a0dd-4754-b60c-ed6d8f2a3ded', 'authenticated', 'authenticated', 'ecommerce@topdashboard.com', '$2a$10$G.IP.gLWW8qAOhl2EGz9tenjGWFzGjI.DWtmVfOiwq6GXarpMoCHy', '2023-10-09 21:41:31.526589+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"role": "ECOMMERCE", "company": "The Outdoor Plus", "last_name": "Account", "first_name": "Ecommerce"}', NULL, '2023-10-09 21:41:31.523848+00', '2023-10-09 21:41:31.52678+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '53191866-daae-404c-807b-1ee85190eebb', 'authenticated', 'authenticated', 'guest@topdashboard.com', '$2a$10$370AYI4lVGRKyE.WHAuH4ecq9B2JwtY45VGFgBzo2iA6z/wsRPbwK', '2023-10-09 21:41:47.120886+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"role": "GUEST", "company": "The Outdoor Plus", "last_name": "Account", "first_name": "Guest"}', NULL, '2023-10-09 21:41:47.118184+00', '2023-10-09 21:41:47.121097+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '2e69f583-266e-4ef6-9202-cda8af9a9884', 'authenticated', 'authenticated', 'jains@theoutdoorplus.com', '$2a$10$LXyDlR4JL/9CIFV2KLv8J.wWjHsCjsYp4SzTpJCcajLEi7HdOCjTm', '2024-03-20 23:08:02.961163+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-04-19 17:27:52.378855+00', '{"provider": "email", "providers": ["email"]}', '{"role": "ADMIN", "company": 1, "last_name": "Lopez", "first_name": "Jains"}', NULL, '2024-03-20 23:08:02.961526+00', '2024-04-19 17:27:52.38125+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '3bc9b49e-448d-45e1-8316-76bc063948db', 'authenticated', 'authenticated', 'group@topdashboard.com', '$2a$10$6eZaa56tercYrkxmEdCL4enZvZ2Z6Djfc71a8yhE9UC.OAMyvqb5q', '2023-10-09 21:37:30.436758+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-03-27 21:08:01.083122+00', '{"provider": "email", "providers": ["email"]}', '{"role": "GROUP", "company": "The Outdoor Plus", "last_name": "Account", "first_name": "Group"}', NULL, '2023-10-09 21:37:30.433153+00', '2024-03-27 21:08:01.084728+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '67b8a91a-f30f-4bde-90a1-7a632e250809', 'authenticated', 'authenticated', 'jesus@theoutdoorplus.com', '$2a$10$B8EWtqFQqstnu8brkolXWOHO0wBSk1Ia63olxzdnR7csKNM4IjFPK', '2023-10-09 22:19:02.716044+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-04-09 21:07:40.305536+00', '{"provider": "email", "providers": ["email"]}', '{"role": "ADMIN", "company": 1, "last_name": "Estrada", "first_name": "Jesus"}', NULL, '2023-10-09 22:19:02.708745+00', '2024-04-09 21:07:40.311007+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '8e267267-0d9a-45fe-b410-014304bcd044', 'authenticated', 'authenticated', 'daniel@theoutdoorplus.com', '$2a$10$g.tEI67cWzqS2P0AT0taqug1nqnpAc0xVc5lWjUAmJp2UvsI9lT5.', '2024-03-20 23:30:09.441515+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-03-20 23:34:03.413913+00', '{"provider": "email", "providers": ["email"]}', '{"role": "ADMIN", "company": 1, "last_name": "Molina", "first_name": "Daniel"}', NULL, '2024-03-20 23:30:09.441865+00', '2024-03-20 23:34:03.415482+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'a41f3520-5ffc-4d5f-966e-b3e6bfdccf28', 'authenticated', 'authenticated', 'joe@theoutdoorplus.com', '$2a$10$DKyMuV47S6gp68STdzlYreyUZTntlbwGHF4fnYXwHLhq4EUSdvCx2', '2024-04-18 23:13:37.472488+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"role": "ADMIN", "company": 1, "last_name": "Estrada", "first_name": "Joseph"}', NULL, '2024-04-18 23:13:37.472831+00', '2024-04-18 23:13:37.482277+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '6029384c-bf78-44a3-8cae-de4e07a9bd6c', 'authenticated', 'authenticated', 'liz@theoutdoorplus.com', '$2a$10$AqIz5Ss1j0a9r.eS6FjGjOsTlVrZOyzbIf9Y66HYrI5eq2SatUyve', '2024-04-18 15:30:10.423373+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-04-18 16:14:14.196069+00', '{"provider": "email", "providers": ["email"]}', '{"role": "MANAGER", "company": 1, "last_name": "Nuñez", "first_name": "Liz"}', NULL, '2024-04-18 15:30:10.423749+00', '2024-04-18 16:14:14.203314+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '9bd05809-c600-4953-a1d6-b1b9110ba752', 'authenticated', 'authenticated', 'dealer@topdashboard.com', '$2a$10$8dnzJBNfT.LkpvUN1YWNvO./doIilUbMJHP0UAUsoISrQW2AzjgJ.', '2023-10-09 21:37:08.188478+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-04-19 17:29:33.278989+00', '{"provider": "email", "providers": ["email"]}', '{"role": "DEALER", "company": 2, "last_name": "Account", "first_name": "Dealer"}', NULL, '2023-10-09 21:37:08.180722+00', '2024-04-19 17:29:33.281865+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '6a2f3947-757e-4808-b260-7142b73bef33', 'authenticated', 'authenticated', 'ivan@theoutdoorplus.com', '$2a$10$oGSa667SlqbBTescSdhojOs0CZwDbiDreI54vASZbw7nBFFInhWmm', '2024-04-18 23:41:39.835818+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-04-19 15:10:54.03391+00', '{"provider": "email", "providers": ["email"]}', '{"role": "ADMIN", "company": 1, "last_name": "Adame", "first_name": "Ivan"}', NULL, '2024-04-18 23:41:39.836164+00', '2024-04-19 15:10:54.037605+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '40db71eb-68d2-402a-ae3f-6bd099418409', 'authenticated', 'authenticated', 'distributor@topdashboard.com', '$2a$10$OpC5OglaxdKUgYiLWNdOEuG2T64eyG1oi8Skfyq14ARRkYTxcfzWu', '2023-10-09 21:40:57.44179+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-01-08 18:41:40.388343+00', '{"provider": "email", "providers": ["email"]}', '{"role": "DISTRIBUTOR", "company": 3, "last_name": "Account", "first_name": "Distributor"}', NULL, '2023-10-09 21:40:57.438977+00', '2024-04-18 23:29:45.577412+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '475d57b8-9842-4a37-be05-2a5527efac99', 'authenticated', 'authenticated', 'rodrigo@theoutdoorplus.com', '$2a$10$If6BKeyW5xSVI0dhNfIt.uImkCduiUhpb3tUPy9aTGwlKCOGMehVe', '2023-08-21 18:29:33.659536+00', NULL, '', NULL, '', NULL, '', '', NULL, '2024-08-07 17:13:12.011569+00', '{"provider": "email", "providers": ["email"]}', '{"role": "ADMIN", "company": 1, "last_name": "Alvarenga", "first_name": "Rodrigo"}', NULL, '2023-08-21 18:29:33.652816+00', '2024-08-07 18:11:39.950652+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('475d57b8-9842-4a37-be05-2a5527efac99', '475d57b8-9842-4a37-be05-2a5527efac99', '{"sub": "475d57b8-9842-4a37-be05-2a5527efac99", "email": "rodrigo@theoutdoorplus.com"}', 'email', '2023-08-21 18:29:33.656761+00', '2023-08-21 18:29:33.656803+00', '2023-08-21 18:29:33.656803+00', '5f7ca920-536c-42a4-9393-253c0e175c10'),
	('3bc9b49e-448d-45e1-8316-76bc063948db', '3bc9b49e-448d-45e1-8316-76bc063948db', '{"sub": "3bc9b49e-448d-45e1-8316-76bc063948db", "email": "group@topdashboard.com"}', 'email', '2023-10-09 21:37:30.434283+00', '2023-10-09 21:37:30.434321+00', '2023-10-09 21:37:30.434321+00', '70c75f59-38e8-41c1-bf7f-97798e594000'),
	('f61ccb8b-5809-4d54-b979-7e39b0398982', 'f61ccb8b-5809-4d54-b979-7e39b0398982', '{"sub": "f61ccb8b-5809-4d54-b979-7e39b0398982", "email": "landscape@topdashboard.com"}', 'email', '2023-10-09 21:39:43.396294+00', '2023-10-09 21:39:43.396332+00', '2023-10-09 21:39:43.396332+00', '543497eb-29f6-4b7b-908c-efeb729234d0'),
	('1a494fcc-4e7c-4541-84f1-70f0a77223bc', '1a494fcc-4e7c-4541-84f1-70f0a77223bc', '{"sub": "1a494fcc-4e7c-4541-84f1-70f0a77223bc", "email": "internet@topdashboard.com"}', 'email', '2023-10-09 21:40:03.227325+00', '2023-10-09 21:40:03.227362+00', '2023-10-09 21:40:03.227362+00', 'e6831d59-0f7c-4bc8-a7f6-b727ce8a53c6'),
	('f059f4c0-d479-467e-844d-0ba3d7c3a270', 'f059f4c0-d479-467e-844d-0ba3d7c3a270', '{"sub": "f059f4c0-d479-467e-844d-0ba3d7c3a270", "email": "master@topdashboard.com"}', 'email', '2023-10-09 21:40:28.728765+00', '2023-10-09 21:40:28.728803+00', '2023-10-09 21:40:28.728803+00', 'e676ca20-c1ef-4a34-a931-f1b153bf8d91'),
	('f186c7f3-a0dd-4754-b60c-ed6d8f2a3ded', 'f186c7f3-a0dd-4754-b60c-ed6d8f2a3ded', '{"sub": "f186c7f3-a0dd-4754-b60c-ed6d8f2a3ded", "email": "ecommerce@topdashboard.com"}', 'email', '2023-10-09 21:41:31.524941+00', '2023-10-09 21:41:31.524976+00', '2023-10-09 21:41:31.524976+00', '588de31a-3946-4378-81b6-b63639c4ec6d'),
	('53191866-daae-404c-807b-1ee85190eebb', '53191866-daae-404c-807b-1ee85190eebb', '{"sub": "53191866-daae-404c-807b-1ee85190eebb", "email": "guest@topdashboard.com"}', 'email', '2023-10-09 21:41:47.119289+00', '2023-10-09 21:41:47.119329+00', '2023-10-09 21:41:47.119329+00', '88854b1c-d5d9-4a18-b18e-ba81f7258035'),
	('40db71eb-68d2-402a-ae3f-6bd099418409', '40db71eb-68d2-402a-ae3f-6bd099418409', '{"sub": "40db71eb-68d2-402a-ae3f-6bd099418409", "email": "distributor@topdashboard.com"}', 'email', '2023-10-09 21:40:57.440126+00', '2023-10-09 21:40:57.440165+00', '2023-10-09 21:40:57.440165+00', '94f4b39a-2f11-401c-b07f-aca9da9a3828'),
	('2e69f583-266e-4ef6-9202-cda8af9a9884', '2e69f583-266e-4ef6-9202-cda8af9a9884', '{"sub": "2e69f583-266e-4ef6-9202-cda8af9a9884", "email": "jains@theoutdoorplus.com", "email_verified": false, "phone_verified": false}', 'email', '2024-03-20 23:08:02.962799+00', '2024-03-20 23:08:02.962846+00', '2024-03-20 23:08:02.962846+00', '5ead5ab1-6103-4085-9253-2205557efc14'),
	('8e267267-0d9a-45fe-b410-014304bcd044', '8e267267-0d9a-45fe-b410-014304bcd044', '{"sub": "8e267267-0d9a-45fe-b410-014304bcd044", "email": "daniel@theoutdoorplus.com", "email_verified": false, "phone_verified": false}', 'email', '2024-03-20 23:30:09.443867+00', '2024-03-20 23:30:09.443916+00', '2024-03-20 23:30:09.443916+00', 'a492d92f-5a54-45b7-a36b-a20c8a97d20b'),
	('67b8a91a-f30f-4bde-90a1-7a632e250809', '67b8a91a-f30f-4bde-90a1-7a632e250809', '{"sub": "67b8a91a-f30f-4bde-90a1-7a632e250809", "email": "jesus@theoutdoorplus.com"}', 'email', '2023-10-09 22:19:02.711359+00', '2023-10-09 22:19:02.711408+00', '2023-10-09 22:19:02.711408+00', '4f5a9cc3-ba28-45f7-9479-08ce99572dce'),
	('6a2f3947-757e-4808-b260-7142b73bef33', '6a2f3947-757e-4808-b260-7142b73bef33', '{"sub": "6a2f3947-757e-4808-b260-7142b73bef33", "email": "ivan@theoutdoorplus.com", "email_verified": false, "phone_verified": false}', 'email', '2024-04-18 23:41:39.838974+00', '2024-04-18 23:41:39.839023+00', '2024-04-18 23:41:39.839023+00', '702563ab-8aec-49ee-b3ea-1c9534a6e08b'),
	('9bd05809-c600-4953-a1d6-b1b9110ba752', '9bd05809-c600-4953-a1d6-b1b9110ba752', '{"sub": "9bd05809-c600-4953-a1d6-b1b9110ba752", "email": "dealer@topdashboard.com"}', 'email', '2023-10-09 21:37:08.184722+00', '2023-10-09 21:37:08.184763+00', '2023-10-09 21:37:08.184763+00', '4906eb71-3ffa-4f90-a1b8-e378d09b7563'),
	('6029384c-bf78-44a3-8cae-de4e07a9bd6c', '6029384c-bf78-44a3-8cae-de4e07a9bd6c', '{"sub": "6029384c-bf78-44a3-8cae-de4e07a9bd6c", "email": "liz@theoutdoorplus.com", "email_verified": false, "phone_verified": false}', 'email', '2024-04-18 15:30:10.426994+00', '2024-04-18 15:30:10.42705+00', '2024-04-18 15:30:10.42705+00', '2580afcd-46ec-4202-8fe5-0363bf76f5d8'),
	('a41f3520-5ffc-4d5f-966e-b3e6bfdccf28', 'a41f3520-5ffc-4d5f-966e-b3e6bfdccf28', '{"sub": "a41f3520-5ffc-4d5f-966e-b3e6bfdccf28", "email": "joe@theoutdoorplus.com", "email_verified": false, "phone_verified": false}', 'email', '2024-04-18 23:13:37.475678+00', '2024-04-18 23:13:37.475726+00', '2024-04-18 23:13:37.475726+00', '89f4cf98-8b5a-41a1-b5d4-cfdeb0d2cf39');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag") VALUES
	('96005d1c-faba-487f-a2ca-a094ecb8fcad', 'f059f4c0-d479-467e-844d-0ba3d7c3a270', '2023-10-11 19:25:43.770987+00', '2023-10-11 19:25:43.770987+00', NULL, 'aal1', NULL, NULL, NULL, NULL, NULL),
	('bbc7f0e6-172f-44b4-887b-b1860a8e82ea', '9bd05809-c600-4953-a1d6-b1b9110ba752', '2024-04-18 22:09:40.660706+00', '2024-04-18 22:09:40.660706+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', '47.176.166.170', NULL),
	('fb646691-2baf-4360-97aa-4e5176c16d4d', '67b8a91a-f30f-4bde-90a1-7a632e250809', '2024-04-09 21:07:40.30561+00', '2024-04-09 21:07:40.30561+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', '47.176.166.170', NULL),
	('eb4ece1d-3e55-4052-b8e2-b4aa404a87a6', '6a2f3947-757e-4808-b260-7142b73bef33', '2024-04-19 15:10:54.033989+00', '2024-04-19 15:10:54.033989+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', '47.176.166.170', NULL),
	('6f262939-f165-470d-9e36-d74c3e73ffdd', '9bd05809-c600-4953-a1d6-b1b9110ba752', '2024-04-19 17:29:33.279056+00', '2024-04-19 17:29:33.279056+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', '47.176.166.170', NULL),
	('3c347261-ba1a-47b7-8719-af966b7f861a', '3bc9b49e-448d-45e1-8316-76bc063948db', '2024-03-27 21:08:01.083209+00', '2024-03-27 21:08:01.083209+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', '47.176.166.170', NULL),
	('ad200a22-f09a-4201-8fb5-71d6d328e8aa', '8e267267-0d9a-45fe-b410-014304bcd044', '2024-03-20 23:34:03.413985+00', '2024-03-20 23:34:03.413985+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', '47.176.166.170', NULL),
	('77c8e9ea-9236-4794-922b-e3f744c8a396', '475d57b8-9842-4a37-be05-2a5527efac99', '2024-08-07 17:13:12.011669+00', '2024-08-07 18:11:39.952406+00', NULL, 'aal1', NULL, '2024-08-07 18:11:39.95232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0', '47.179.36.170', NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('96005d1c-faba-487f-a2ca-a094ecb8fcad', '2023-10-11 19:25:43.773911+00', '2023-10-11 19:25:43.773911+00', 'password', '4acbb6b1-d82b-4b8b-abfe-6544414bac98'),
	('bbc7f0e6-172f-44b4-887b-b1860a8e82ea', '2024-04-18 22:09:40.664944+00', '2024-04-18 22:09:40.664944+00', 'password', 'fb99d9a5-8b4d-4dc3-a211-a328646ea064'),
	('eb4ece1d-3e55-4052-b8e2-b4aa404a87a6', '2024-04-19 15:10:54.037861+00', '2024-04-19 15:10:54.037861+00', 'password', '8622f0d3-2366-4195-a187-f387c5097d1b'),
	('6f262939-f165-470d-9e36-d74c3e73ffdd', '2024-04-19 17:29:33.282104+00', '2024-04-19 17:29:33.282104+00', 'password', 'ae8a8497-7d99-4168-9da9-3da071d9a2af'),
	('ad200a22-f09a-4201-8fb5-71d6d328e8aa', '2024-03-20 23:34:03.415719+00', '2024-03-20 23:34:03.415719+00', 'password', 'b70e1cb0-7301-47b5-8475-1e8964e0cdb7'),
	('3c347261-ba1a-47b7-8719-af966b7f861a', '2024-03-27 21:08:01.084965+00', '2024-03-27 21:08:01.084965+00', 'password', '7c951d9c-8dde-480a-b7e3-ae41c9512bd1'),
	('fb646691-2baf-4360-97aa-4e5176c16d4d', '2024-04-09 21:07:40.311243+00', '2024-04-09 21:07:40.311243+00', 'password', 'd0e554a6-1898-45e0-9b4c-509798fefff0'),
	('77c8e9ea-9236-4794-922b-e3f744c8a396', '2024-08-07 17:13:12.014929+00', '2024-08-07 17:13:12.014929+00', 'password', 'f2b36e9f-7157-4e74-9395-5c22de3f448e');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 71, 'ETrBHDUM05rkwly8myyTzg', 'f059f4c0-d479-467e-844d-0ba3d7c3a270', false, '2023-10-11 19:25:43.77223+00', '2023-10-11 19:25:43.77223+00', NULL, '96005d1c-faba-487f-a2ca-a094ecb8fcad'),
	('00000000-0000-0000-0000-000000000000', 426, 'Y87QbybF_9UtYJ0J_Hn0uA', '9bd05809-c600-4953-a1d6-b1b9110ba752', false, '2024-04-18 22:09:40.663255+00', '2024-04-18 22:09:40.663255+00', NULL, 'bbc7f0e6-172f-44b4-887b-b1860a8e82ea'),
	('00000000-0000-0000-0000-000000000000', 429, 'FfbVk6FD8psEuLN7-7VP1Q', '6a2f3947-757e-4808-b260-7142b73bef33', false, '2024-04-19 15:10:54.035931+00', '2024-04-19 15:10:54.035931+00', NULL, 'eb4ece1d-3e55-4052-b8e2-b4aa404a87a6'),
	('00000000-0000-0000-0000-000000000000', 311, 'Rzqbszp-y2MEzRprNeGY1w', '67b8a91a-f30f-4bde-90a1-7a632e250809', false, '2024-04-09 21:07:40.30969+00', '2024-04-09 21:07:40.30969+00', NULL, 'fb646691-2baf-4360-97aa-4e5176c16d4d'),
	('00000000-0000-0000-0000-000000000000', 431, '0d1JVDeFgkX_qy2r2FeEvA', '9bd05809-c600-4953-a1d6-b1b9110ba752', false, '2024-04-19 17:29:33.281023+00', '2024-04-19 17:29:33.281023+00', NULL, '6f262939-f165-470d-9e36-d74c3e73ffdd'),
	('00000000-0000-0000-0000-000000000000', 291, 'LKcUnyo8zeqA4abLCaxg3Q', '3bc9b49e-448d-45e1-8316-76bc063948db', false, '2024-03-27 21:08:01.083902+00', '2024-03-27 21:08:01.083902+00', NULL, '3c347261-ba1a-47b7-8719-af966b7f861a'),
	('00000000-0000-0000-0000-000000000000', 269, '1yMHkusUG_U-PXUEzc6RHA', '8e267267-0d9a-45fe-b410-014304bcd044', false, '2024-03-20 23:34:03.414678+00', '2024-03-20 23:34:03.414678+00', NULL, 'ad200a22-f09a-4201-8fb5-71d6d328e8aa'),
	('00000000-0000-0000-0000-000000000000', 437, 'dzbU3yCDePZZxQYeSrtKEg', '475d57b8-9842-4a37-be05-2a5527efac99', true, '2024-08-07 17:13:12.013744+00', '2024-08-07 18:11:39.949034+00', NULL, '77c8e9ea-9236-4794-922b-e3f744c8a396'),
	('00000000-0000-0000-0000-000000000000', 438, '8yfHNZGeruO180hz8cil6g', '475d57b8-9842-4a37-be05-2a5527efac99', false, '2024-08-07 18:11:39.949626+00', '2024-08-07 18:11:39.949626+00', 'dzbU3yCDePZZxQYeSrtKEg', '77c8e9ea-9236-4794-922b-e3f744c8a396');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--



--
-- Data for Name: attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."attributes" ("id", "name", "table_name", "slug") VALUES
	(2, 'Color', 'color', 'color'),
	(4, 'Material', 'material', 'material'),
	(1, 'Gas Type', 'gas', 'gas-type'),
	(3, 'Ignition Type', 'ignition', 'ignition-type'),
	(14, 'Size', NULL, 'size'),
	(16, 'LED LIghts', NULL, 'led-lights');


--
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."material" ("id", "name", "slug", "image_url") VALUES
	(32, 'Powder Coat', 'powder-coat', NULL),
	(33, 'GFRC Concrete', 'gfrc-concrete', NULL),
	(34, 'Hammered Copper', 'hammered-copper', 'https://www.dropbox.com/scl/fi/mb7n4f7wdtiwn22zfbfsi/Hammered-Copper.png?rlkey=iyi2p5pd7jtx2g9g94zbu97jh&raw=1'),
	(30, 'Corten Steel', 'corten-steel', 'https://www.dropbox.com/scl/fi/v8scoj09afe6d0vqj92hx/CORTEN-Weathering-Steel.jpg?rlkey=ctlobmnkuzp5zvq2a5dst8dws&raw=1'),
	(31, 'Stainless Steel', 'stainless-steel', 'https://www.dropbox.com/scl/fi/15sujkytbm9n5q3z0lexh/Stainless-Steel-Finish.jpg?rlkey=p0oozfl1edbklccuffgk1w5ik&raw=1'),
	(35, 'GFRC Woodgrain', 'gfrc-woodgrain', NULL);


--
-- Data for Name: color; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."color" ("id", "name", "slug", "material_id", "image_url") VALUES
	(30, 'Ash', 'ash', 33, 'https://www.dropbox.com/scl/fi/1oowfkwx3oj9xqbn4tfa1/Ash-GFRC-Smooth-Finish_2.jpg?rlkey=ydptbp3lc57vpdieeip91ngfe&raw=1'),
	(31, 'Black', 'black', 33, 'https://www.dropbox.com/scl/fi/s42hbg6mh6nc2s87es2u2/Black-GFRC-Smooth-Finish_2.jpg?rlkey=kym55csxa93ftpiqgaua3oq9v&raw=1'),
	(33, 'Chestnut', 'chestnut', 33, 'https://www.dropbox.com/scl/fi/22hdek8lf0t2nx1pwq0cf/Chestnut-GFRC-Smooth-Finish_2.jpg?rlkey=25i7ef91ccchqm692sc8sww8b&raw=1'),
	(34, 'Chocolate', 'chocolate', 33, 'https://www.dropbox.com/scl/fi/tc1e8bibcti3g6e1zpp0g/Chocolate-GFRC-Smooth-Finish_2.jpg?rlkey=ek3eolrqb8nwbnqu2pte403hn&raw=1'),
	(35, 'Rustic Coffee', 'rustic-coffee', 33, 'https://www.dropbox.com/scl/fi/hmwq6hplipqzxkrx4s4fj/Coffee-GFRC-Rustic-Finish.jpg?rlkey=vro5mxdhjmh4yhvqq6dhbswny&raw=1'),
	(32, 'Metallic Bronze', 'metallic-bronze', 33, 'https://www.dropbox.com/scl/fi/pifjq8rjwslc2rkgrnv18/Bronze-Metallic-GFRC-Swatch.jpg?rlkey=0f6md8eiffktty06di7s6ff2r&raw=1'),
	(36, 'Metallic Copper', 'metallic-copper', 33, 'https://www.dropbox.com/scl/fi/dby2pl1zirocyacsry3et/Copper-GFRC-Metallic-Finish.jpg?rlkey=djh0exlscy9yyozrvqofctx8z&raw=1'),
	(37, 'Gray', 'gray', 33, 'https://www.dropbox.com/scl/fi/vm3bl3xj6mnxt3v5g80l0/Gray-GFRC-Smooth-Finish_2.jpg?rlkey=2xm1gmtwei95z8v389qwxkn8l&raw=1'),
	(38, 'Limestone', 'limestone', 33, 'https://www.dropbox.com/scl/fi/zvp1x5g3k2e6ieab95e9s/Limestone-GFRC-Smooth-Finish_2.jpg?rlkey=dpmp6ai6x4tcuyb44foayln33&raw=1'),
	(39, 'Rustic Moss Stone', 'rustic-moss-stone', 33, 'https://www.dropbox.com/scl/fi/p53mkrnlc3yivbkrd55hv/Moss-Stone-GFRC-Rustic-Finish.jpg?rlkey=vo38i94xuu8rm77jk6fi1g7x2&raw=1'),
	(40, 'Natural Gray', 'natural-gray', 33, 'https://www.dropbox.com/scl/fi/bpe1uupw4w0fk8lnaioid/Natural-Gray-GFRC-Smooth-Finish_2.jpg?rlkey=cfxg67kc4s448tw1oqb9v4xqy&raw=1'),
	(41, 'Metallic Pearl', 'metallic-pearl', 33, 'https://www.dropbox.com/scl/fi/8273kzsbp8a3s16dfs1rj/Pearl-GFRC-Metallic-Finish.jpg?rlkey=bnz7d5wvv71w2kuwglyac8i93&raw=1'),
	(42, 'Rustic Gray', 'rustic-gray', 33, 'https://www.dropbox.com/scl/fi/8gz829okbykrvvb411w2q/Rustic-Gray-GFRC-Rustic-Finish.jpg?rlkey=e92d60laigx5w1qcjz6axo21v&raw=1'),
	(43, 'Rustic White', 'rustic-white', 33, 'https://www.dropbox.com/scl/fi/dtmka29o2craaqit7jhq2/Rustic-White-GFRC-Rustic-Finish.jpg?rlkey=lot7s2nwlgti5aya5jkdhwkan&raw=1'),
	(44, 'Metallic Silver', 'metallic-silver', 33, 'https://www.dropbox.com/scl/fi/kn15e2x9xlcn8srgjwg3f/Silver-GFRC-Metallic-Finish-1.jpg?rlkey=oeoykpj9cs77xjvj43h270ozy&raw=1'),
	(45, 'Metallic Slate', 'metallic-slate', 33, 'https://www.dropbox.com/scl/fi/7eixdn6afv75lkcxf3jfu/Slate-Metallic-GFRC-Swatch.jpg?rlkey=9bv4516ili4pvaakpai116z0r&raw=1'),
	(46, 'Vanilla', 'vanilla', 33, 'https://www.dropbox.com/scl/fi/zfc38ay4shp9hbivl7871/Vanilla-GFRC-Smooth-Finish_2.jpg?rlkey=4gp7q9ky03satadzagwwnnt5y&raw=1'),
	(47, 'Brown', 'brown', 33, 'https://www.dropbox.com/scl/fi/zod92moe0qva5tc9os842/Brown-GFRC-Smooth-Finish_2.jpg?rlkey=4uj1o9k5y8o133ea3gapqcmdi&raw=1'),
	(48, 'Ebony', 'ebony', 35, 'https://www.dropbox.com/scl/fi/ax2d0oz2816bjse1jcg69/Ebony-GFRC-Wood-Grain.jpg?rlkey=fdrdhg3aqg6h9okosfyjrxnqw&raw=1'),
	(49, 'Ivory', 'ivory', 35, 'https://www.dropbox.com/scl/fi/p3jb7n7jg44ug269pkv6y/Ivory-GFRC-Wood-Grain.jpg?rlkey=d3by4xp1gm0bs7z9wlkxztf38&raw=1'),
	(50, 'Oak', 'oak', 35, 'https://www.dropbox.com/scl/fi/dt5v72s9oy75vx1420i6w/Oak-GFRC-Wood-Grain-1.jpg?rlkey=7oim7xnbxrepuzrpqhqw6xeo0&raw=1'),
	(29, 'Black (Gloss)', 'gloss-black', 32, 'https://www.dropbox.com/scl/fi/oc6nc384lizduzw7tvpen/Black-Gloss-Powder-Coat.jpg?rlkey=zbosqqhrwu1tuvma1b77ghq90&raw=1'),
	(51, 'Sapphire Blue', 'sapphire-blue', 32, 'https://www.dropbox.com/scl/fi/yhw04356zstfeey9wbndw/02_Sapphire-Blue.jpg?rlkey=a4gq6ownnxyjjl58xc26p751g&raw=1'),
	(52, 'Bronze Hammertone', 'bronze-hammertone', 32, 'https://www.dropbox.com/scl/fi/qwikvpizk1ywarxd38mor/Bronze-Hammertone-BZHT.jpg?rlkey=noy4avir5x2gfwe0gk28tyrje&raw=1'),
	(53, 'Copper Vein', 'copper-vein', 32, 'https://www.dropbox.com/scl/fi/zh02or09pf0gzkcgcq5zt/Copper-Vein-Powder-Coat.jpg?rlkey=sj5zrwk1t4p2bb09xeuqf1jmr&raw=1'),
	(55, 'Gray', 'gray', 32, 'https://www.dropbox.com/scl/fi/67u7srhfokl8mnaxd5xan/Gray-Powder-Coat.jpg?rlkey=sd6xzy08otvgkc27cwlurfsr4&raw=1'),
	(56, 'Java', 'java', 32, 'https://www.dropbox.com/scl/fi/z7v8r0h73id9ypl0kshqn/Java-Powder-Coat.jpg?rlkey=2h00gh7udve0jvuyu4jsl9szs&raw=1'),
	(57, 'Mist', 'mist', 32, 'https://www.dropbox.com/scl/fi/nkkel4jutczwejh732sbt/Mist-MST.jpg?rlkey=pd902cvo7e4ksiycee4j3kykb&raw=1'),
	(58, 'Olive Green', 'olive-green', 32, 'https://www.dropbox.com/scl/fi/nadm864jcmsp85a7k19ci/Olive-Green-MGR.jpg?rlkey=0l5pcnqeg1pij6ub78u17igqm&raw=1'),
	(59, 'Onyx Black (Matte)', 'onyx-black-matte', 32, 'https://www.dropbox.com/scl/fi/j33hs1xxqwtnhl007qsyq/Onyx-Black-Matte-ONX.jpg?rlkey=8xlzkoa2y7x3ug0m30mbqa5jb&raw=1'),
	(60, 'Pewter', 'pewter', 32, 'https://www.dropbox.com/scl/fi/7984fr3vk7fbbvqwj2pdm/Pewter-Powder-Coat.jpg?rlkey=yzawmr6eemjra49mz68h45h1p&raw=1'),
	(61, 'Silver Vein', 'silver-vein', 32, 'https://www.dropbox.com/scl/fi/gjpv95xlemhcxg3xvlj87/Silver-Vein-Powder-Coat.jpg?rlkey=21761ax01w6bjmmnmo8t0xjxf&raw=1'),
	(62, 'Soft White', 'soft-white', 32, 'https://www.dropbox.com/scl/fi/j6gciqekts6m0m2x912aj/Soft-White-STW.jpg?rlkey=h4nf72gmojb4g2h61x0qz4m3r&raw=1'),
	(63, 'White Vein', 'white-vein', 32, 'https://www.dropbox.com/scl/fi/j5gu2mstg4xt9rc8msuda/White-Vein-WHTV.jpg?rlkey=zoelvzgkhmscswojh2xp4h23a&raw=1'),
	(64, 'White', 'white', 32, 'https://www.dropbox.com/scl/fi/13wy2gj9f1rx5oe47vkrm/White-Powdercoat.jpg?rlkey=zmgh8uvlwkjdwylbq454vl00j&raw=1');


--
-- Data for Name: gas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."gas" ("id", "name", "slug") VALUES
	(6, 'Liquid Propane', 'liquid-propane'),
	(7, 'Natural Gas', 'natural-gas'),
	(8, 'Wood Burning', 'wood-burning');


--
-- Data for Name: ignition; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."ignition" ("id", "name", "slug") VALUES
	(9, 'Match Lit Ignition', 'match-lit-ignition'),
	(10, 'Match Lit with Flame Sense Ignition (LC Certified)', 'match-lit-with-flame-sense-ignition-lc-certified'),
	(11, 'Flame Sense with Spark Ignition', 'flame-sense-with-spark-ignition'),
	(12, 'Low Voltage Electronic Ignition (CSA Certified)', 'low-voltage-electronic-ignition-csa-certified'),
	(13, 'Plug & Play (CSA Certified)', 'plug-play-csa-certified');


--
-- Data for Name: attribute_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."attribute_value" ("id", "attribute_id", "value", "material_id", "color_id", "gas_id", "ignition_id", "slug") VALUES
	(8, 4, NULL, 30, NULL, NULL, NULL, NULL),
	(9, 4, NULL, 31, NULL, NULL, NULL, NULL),
	(10, 3, NULL, NULL, NULL, NULL, 9, NULL),
	(28, 4, NULL, 32, NULL, NULL, NULL, NULL),
	(29, 2, NULL, NULL, 29, NULL, NULL, NULL),
	(41, 1, NULL, NULL, NULL, 6, NULL, NULL),
	(42, 4, NULL, 33, NULL, NULL, NULL, NULL),
	(43, 4, NULL, 34, NULL, NULL, NULL, NULL),
	(44, 4, NULL, 35, NULL, NULL, NULL, NULL),
	(45, 2, NULL, NULL, 30, NULL, NULL, NULL),
	(46, 2, NULL, NULL, 31, NULL, NULL, NULL),
	(47, 2, NULL, NULL, 32, NULL, NULL, NULL),
	(48, 2, NULL, NULL, 33, NULL, NULL, NULL),
	(49, 2, NULL, NULL, 34, NULL, NULL, NULL),
	(50, 2, NULL, NULL, 35, NULL, NULL, NULL),
	(51, 2, NULL, NULL, 36, NULL, NULL, NULL),
	(52, 2, NULL, NULL, 37, NULL, NULL, NULL),
	(53, 2, NULL, NULL, 38, NULL, NULL, NULL),
	(54, 2, NULL, NULL, 39, NULL, NULL, NULL),
	(55, 2, NULL, NULL, 40, NULL, NULL, NULL),
	(56, 2, NULL, NULL, 41, NULL, NULL, NULL),
	(57, 2, NULL, NULL, 42, NULL, NULL, NULL),
	(58, 2, NULL, NULL, 43, NULL, NULL, NULL),
	(59, 2, NULL, NULL, 44, NULL, NULL, NULL),
	(60, 2, NULL, NULL, 45, NULL, NULL, NULL),
	(61, 2, NULL, NULL, 46, NULL, NULL, NULL),
	(62, 2, NULL, NULL, 47, NULL, NULL, NULL),
	(63, 2, NULL, NULL, 48, NULL, NULL, NULL),
	(64, 2, NULL, NULL, 49, NULL, NULL, NULL),
	(65, 2, NULL, NULL, 50, NULL, NULL, NULL),
	(66, 2, NULL, NULL, 51, NULL, NULL, NULL),
	(67, 2, NULL, NULL, 52, NULL, NULL, NULL),
	(68, 2, NULL, NULL, 53, NULL, NULL, NULL),
	(70, 2, NULL, NULL, 55, NULL, NULL, NULL),
	(71, 2, NULL, NULL, 56, NULL, NULL, NULL),
	(72, 2, NULL, NULL, 57, NULL, NULL, NULL),
	(73, 2, NULL, NULL, 58, NULL, NULL, NULL),
	(74, 2, NULL, NULL, 59, NULL, NULL, NULL),
	(75, 2, NULL, NULL, 60, NULL, NULL, NULL),
	(76, 2, NULL, NULL, 61, NULL, NULL, NULL),
	(77, 2, NULL, NULL, 62, NULL, NULL, NULL),
	(78, 2, NULL, NULL, 63, NULL, NULL, NULL),
	(79, 2, NULL, NULL, 64, NULL, NULL, NULL),
	(85, 1, NULL, NULL, NULL, 7, NULL, NULL),
	(86, 14, '48"', NULL, NULL, NULL, NULL, '48-'),
	(87, 14, '36"', NULL, NULL, NULL, NULL, '36-'),
	(88, 14, '24"', NULL, NULL, NULL, NULL, '24-'),
	(89, 14, '31"', NULL, NULL, NULL, NULL, '31-'),
	(90, 14, '72"', NULL, NULL, NULL, NULL, '72-'),
	(92, 14, '60"', NULL, NULL, NULL, NULL, '60-'),
	(93, 14, '84"', NULL, NULL, NULL, NULL, '84-'),
	(94, 14, '96"', NULL, NULL, NULL, NULL, '96-'),
	(95, 1, NULL, NULL, NULL, 8, NULL, NULL),
	(96, 3, NULL, NULL, NULL, NULL, 10, NULL),
	(97, 3, NULL, NULL, NULL, NULL, 11, NULL),
	(98, 3, NULL, NULL, NULL, NULL, 12, NULL),
	(99, 3, NULL, NULL, NULL, NULL, 13, NULL),
	(101, 16, 'No', NULL, NULL, NULL, NULL, 'no'),
	(102, 16, 'Yes', NULL, NULL, NULL, NULL, 'yes');


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."category" ("id", "name", "slug", "parent_id") VALUES
	(11, 'Planter & Water Bowls', 'planter-and-water-bowls', 1),
	(12, 'Concrete Planter & Water Bowls', 'concrete-planter-and-water-bowls', 11),
	(13, 'Metal Planter & Water Bowls', 'metal-planter-and-water-bowls', 11),
	(14, 'Planter Bowls', 'planter-bowls', 1),
	(15, 'Concrete Planter Bowls', 'concrete-planter-bowls', 14),
	(16, 'Metal Planter Bowls', 'metal-planter-bowls', 14),
	(17, 'Fire Pits & Tables', 'fire-pits-and-tables', NULL),
	(18, 'Round Fire Pits & Tables', 'round-fire-pits-and-tables', 17),
	(19, 'GFRC Concrete Round Fire Pits & Tables', 'gfrc-concrete-round-fire-pits-and-tables', 18),
	(20, 'Metal Round Fire Pits & Tables', 'metal-round-fire-pits-and-tables', 18),
	(21, 'Ready To Finish Round Fire Pits & Tables', 'ready-to-finish-round-fire-pits-and-tables', 18),
	(1, 'Bowls', 'bowls', NULL),
	(2, 'Fire Bowls', 'fire-bowls', 1),
	(3, 'Metal Fire Bowls', 'metal-fire-bowls', 2),
	(4, 'Concrete Fire Bowls', 'concrete-fire-bowls', 2),
	(5, 'Fire & Water Bowls', 'fire-and-water-bowls', 1),
	(6, 'Concrete Fire & Water Bowls', 'concrete-fire-and-water-bowls', 5),
	(7, 'Metal Fire & Water Bowls', 'metal-fire-and-water-bowls', 5),
	(8, 'Water Bowls', 'water-bowls', 1),
	(9, 'Concrete Water Bowls', 'concrete-water-bowls', 8),
	(10, 'Metal Water Bowls', 'metal-water-bowls', 8),
	(22, 'Square Fire Pits & Tables', 'square-fire-pits-and-tables', 17),
	(23, 'GFRC Concrete Square Fire Pits & Tables', 'gfrc-concrete-square-fire-pits-and-tables', 22),
	(24, 'Metal Square Fire Pits & Tables', 'metal-square-fire-pits-and-tables', 22),
	(25, 'Ready To Finish Square Fire Pits & Tables', 'ready-to-finish-square-fire-pits-and-tables', 22),
	(26, 'Rectangular Fire Pits & Tables', 'rectangular-fire-pits-and-tables', 17),
	(27, 'GFRC Concrete Rectangular Fire Pits & Tables', 'gfrc-concrete-rectangular-fire-pits-and-tables', 26),
	(28, 'Metal Rectangular Fire Pits & Tables', 'metal-rectangular-fire-pits-and-tables', 26),
	(29, 'Ready To Finish Rectangular Fire Pits & Tables', 'ready-to-finish-rectangular-fire-pits-and-tables', 26),
	(30, 'Other Fire Pits & Tables', 'other-fire-pits-and-tables', 17),
	(31, 'GFRC Concrete Other Fire Pits & Tables', 'gfrc-concrete-other-fire-pits-and-tables', 30),
	(32, 'Metal Other Fire Pits & Tables', 'metal-other-fire-pits-and-tables', 30),
	(33, 'Ready To Finish Other Fire Pits & Tables', 'ready-to-finish-other-fire-pits-and-tables', 30),
	(36, 'BBQ Island Kits', 'bbq-island-kits', 35),
	(37, 'BBQ Islands Accessories', 'bbq-islands-accessories', 34),
	(38, 'BBQ Tool Set', 'bbq-tool-set', 37),
	(39, 'Doors', 'doors', 37),
	(40, 'Doors & Drawers', 'doors-drawers', 37),
	(41, 'Drawers', 'drawers', 37),
	(42, 'Trash Disposal', 'trash-disposal', 37),
	(43, 'Grills', 'grills', 34),
	(44, 'Built In Grills', 'built-in-grills', 43),
	(45, 'Griddle', 'griddle', 43),
	(46, 'Grill Carts', 'grill-carts', 43),
	(47, 'Side Burners', 'side-burners', 43),
	(48, 'Grills Accessories', 'grills-accessories', 34),
	(49, 'Burners', 'burners', 48),
	(50, 'Fire Structures', 'fire-structures', NULL),
	(51, 'Fireplaces', 'fireplaces', NULL),
	(52, 'Fire Towers & Torches', 'fire-towers-and-torches', NULL),
	(53, 'Fire Towers', 'fire-towers', 52),
	(54, 'Torches', 'torches', 52),
	(34, 'Diamond Grills BBQ', 'diamond-grills-bbq', NULL),
	(35, 'BBQ Islands', 'bbq-islands', 34);


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."collection" ("id", "name", "slug") VALUES
	(7, 'Cazo', 'cazo'),
	(42, 'Alameda', 'alameda'),
	(43, 'Alberta', 'alberta'),
	(44, 'Altisimo', 'altisimo'),
	(45, 'Alto', 'alto'),
	(46, 'Amina', 'amina'),
	(47, 'Angelus', 'angelus'),
	(48, 'Angled Mini', 'angled-mini'),
	(49, 'Arch Flow', 'arch-flow'),
	(50, 'Astoria', 'astoria'),
	(51, 'Atlas', 'atlas'),
	(52, 'Avalon', 'avalon'),
	(53, 'Baja', 'baja'),
	(54, 'Balboa', 'balboa'),
	(55, 'Bastille', 'bastille'),
	(56, 'Baston', 'baston'),
	(57, 'Bayside', 'bayside'),
	(58, 'Bella', 'bella'),
	(59, 'Beverly', 'beverly'),
	(60, 'Big Sur', 'big-sur'),
	(61, 'Billow', 'billow'),
	(62, 'Bispo', 'bispo'),
	(63, 'Box', 'box'),
	(64, 'Burn Area Cover', 'burn-area-cover'),
	(65, 'Burner Only', 'burner-only'),
	(66, 'Burning Media', 'burning-media'),
	(67, 'Cabo', 'cabo'),
	(68, 'Calabasas', 'calabasas'),
	(69, 'Cannon', 'cannon'),
	(70, 'Canvas Cover', 'canvas-cover'),
	(71, 'Carmen', 'carmen'),
	(72, 'Carson', 'carson'),
	(73, 'Castillo', 'castillo'),
	(74, 'Catalina', 'catalina'),
	(75, 'Cesto', 'cesto'),
	(76, 'Chamfered', 'chamfered'),
	(77, 'Classic Bus', 'classic-bus'),
	(78, 'Coastline', 'coastline'),
	(79, 'Copa', 'copa'),
	(80, 'Coronado', 'coronado'),
	(81, 'Cove', 'cove'),
	(82, 'Dana', 'dana'),
	(83, 'Del Mar', 'del-mar'),
	(84, 'Dixie', 'dixie'),
	(85, 'Eaves', 'eaves'),
	(86, 'Fireplace', 'fireplace'),
	(87, 'Fireplace Screen', 'fireplace-screen'),
	(88, 'Florence', 'florence'),
	(89, 'Forma', 'forma'),
	(90, 'Fremont', 'fremont'),
	(91, 'Fresno', 'fresno'),
	(92, 'Frisco', 'frisco'),
	(93, 'Gallaway', 'gallaway'),
	(94, 'Gladiator', 'gladiator'),
	(95, 'Glass Wind Guard', 'glass-wind-guard'),
	(96, 'Granada', 'granada'),
	(97, 'Grove', 'grove'),
	(98, 'Hana', 'hana'),
	(99, 'Harbor', 'harbor'),
	(100, 'Hay Stack', 'hay-stack'),
	(101, 'Heat Reflector', 'heat-reflector'),
	(102, 'Heiko', 'heiko'),
	(103, 'High-Rise', 'high-rise'),
	(104, 'Imperial', 'imperial'),
	(105, 'Isla', 'isla'),
	(106, 'Kamoa', 'kamoa'),
	(107, 'La Jolla', 'la-jolla'),
	(108, 'La Pinta', 'la-pinta'),
	(109, 'Laguna', 'laguna'),
	(110, 'LED Gladiator', 'led-gladiator'),
	(111, 'LED Lighthouse', 'led-lighthouse'),
	(112, 'LED Manila', 'led-manila'),
	(113, 'Linear Maya', 'linear-maya'),
	(114, 'Lucia', 'lucia'),
	(115, 'Luna', 'luna'),
	(116, 'Mabel', 'mabel'),
	(117, 'Martillo', 'martillo'),
	(118, 'Maverick Torch', 'maverick-torch'),
	(119, 'Maya', 'maya'),
	(120, 'Maywood', 'maywood'),
	(121, 'Merona', 'merona'),
	(122, 'Mesa', 'mesa'),
	(123, 'Moderna', 'moderna'),
	(124, 'Moderno', 'moderno'),
	(125, 'Moonstone', 'moonstone'),
	(126, 'Newport', 'newport'),
	(127, 'Newton', 'newton'),
	(128, 'Nile', 'nile'),
	(129, 'Octagon', 'octagon'),
	(130, 'Olympian', 'olympian'),
	(131, 'Original TOP Torch', 'original-top-torch'),
	(132, 'Ornament', 'ornament'),
	(133, 'Outback', 'outback'),
	(134, 'Outdoor Seating', 'outdoor-seating'),
	(135, 'Palo', 'palo'),
	(136, 'Pan & Burner Kit', 'pan-burner-kit'),
	(137, 'Paradise', 'paradise'),
	(138, 'Pismo', 'pismo'),
	(139, 'Plymouth', 'plymouth'),
	(140, 'Pointe', 'pointe'),
	(141, 'Propane Tank Enclosure', 'propane-tank-enclosure'),
	(142, 'Quad', 'quad'),
	(143, 'Radius', 'radius'),
	(144, 'Rainfall', 'rainfall'),
	(145, 'Ramona', 'ramona'),
	(146, 'Redan', 'redan'),
	(147, 'Regal', 'regal'),
	(148, 'Remi', 'remi'),
	(149, 'Replacement Bowl Scupper', 'replacement-bowl-scupper'),
	(150, 'Rodeo', 'rodeo'),
	(151, 'Roma', 'roma'),
	(152, 'RTF Outdoor Fireplace', 'rtf-outdoor-fireplace'),
	(153, 'RTF Trilogy', 'rtf-trilogy'),
	(154, 'Salinas', 'salinas'),
	(155, 'San Juan', 'san-juan'),
	(156, 'Scalloped', 'scalloped'),
	(157, 'Scoop Style', 'scoop-style'),
	(158, 'Seal Rock', 'seal-rock'),
	(159, 'Seashore', 'seashore'),
	(160, 'Sedona', 'sedona'),
	(161, 'Seqouia', 'seqouia'),
	(162, 'Sienna', 'sienna'),
	(163, 'Sierra', 'sierra'),
	(164, 'Single V Style', 'single-v-style'),
	(165, 'Smooth Flow', 'smooth-flow'),
	(166, 'Smooth Flow Radius', 'smooth-flow-radius'),
	(167, 'Sonoma', 'sonoma'),
	(168, 'Straight Spillway', 'straight-spillway'),
	(169, 'Tacoma', 'tacoma'),
	(170, 'Tempe', 'tempe'),
	(171, 'The Fire Lodge', 'the-fire-lodge'),
	(172, 'Tidal', 'tidal'),
	(173, 'TOP Components', 'top-components'),
	(174, 'TOP-lite Torch', 'top-lite-torch'),
	(175, 'Tuscon', 'tuscon'),
	(176, 'Unity', 'unity'),
	(177, 'U-Shaped', 'u-shaped'),
	(178, 'Uxmal', 'uxmal'),
	(179, 'Vallejo', 'vallejo'),
	(180, 'Vernon', 'vernon'),
	(181, 'Vista', 'vista'),
	(182, 'V-Shaped', 'v-shaped'),
	(183, 'Water Over Fire Kit', 'water-over-fire-kit'),
	(184, 'Whitney', 'whitney');


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."company" ("id", "created_at", "name", "slug", "logo_url", "role") VALUES
	(1, '2024-04-15 21:19:17.980617+00', 'The Outdoor Plus', 'the-outdoor-plus', 'https://www.dropbox.com/scl/fi/7mh9kwtoain4g0yxb7js9/TOP_Logo_OB.png?rlkey=clwe9m9yhvq13fhr4h96286xz&raw=1', 'SALES'),
	(2, '2024-04-15 21:41:27.855956+00', 'The Fire Pit Collection', 'the-fire-pit-collection', 'https://www.dropbox.com/scl/fi/a4xx81fr06zlqqznd7rm3/TFPC_logo_white.webp?rlkey=sg2b70clc6796t7f5jsnvnajy&raw=1', 'DEALER'),
	(3, '2024-04-15 21:42:10.579452+00', 'Starfire Direct', 'starfire-direct', 'https://www.dropbox.com/scl/fi/agr0c8ageiswzznzooya3/sd_logo.png?rlkey=epg4umvxdo74uqi22nwco16nn&raw=1', 'DISTRIBUTOR');


--
-- Data for Name: shape; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."shape" ("id", "name", "slug") VALUES
	(11, 'Round', 'round'),
	(12, 'Square', 'square'),
	(13, 'Rectangular', 'rectangular');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."users" ("id", "first_name", "email", "last_name", "role", "company") VALUES
	('3bc9b49e-448d-45e1-8316-76bc063948db', 'Group', 'group@topdashboard.com', 'Account', 'GROUP', NULL),
	('f61ccb8b-5809-4d54-b979-7e39b0398982', 'Landscape', 'landscape@topdashboard.com', 'Account', 'LANDSCAPE', NULL),
	('1a494fcc-4e7c-4541-84f1-70f0a77223bc', 'Internet', 'internet@topdashboard.com', 'Account', 'INTERNET', NULL),
	('f059f4c0-d479-467e-844d-0ba3d7c3a270', 'Master Distributor', 'master@topdashboard.com', 'Account', 'MASTER_DISTRIBUTOR', NULL),
	('f186c7f3-a0dd-4754-b60c-ed6d8f2a3ded', 'Ecommerce', 'ecommerce@topdashboard.com', 'Account', 'ECOMMERCE', NULL),
	('53191866-daae-404c-807b-1ee85190eebb', 'Guest', 'guest@topdashboard.com', 'Account', 'GUEST', NULL),
	('9bd05809-c600-4953-a1d6-b1b9110ba752', 'Dealer', 'dealer@topdashboard.com', 'Account', 'DEALER', 2),
	('67b8a91a-f30f-4bde-90a1-7a632e250809', 'Jesus', 'jesus@theoutdoorplus.com', 'Estrada', 'ADMIN', 1),
	('8e267267-0d9a-45fe-b410-014304bcd044', 'Daniel', 'daniel@theoutdoorplus.com', 'Molina', 'ADMIN', 1),
	('2e69f583-266e-4ef6-9202-cda8af9a9884', 'Jains', 'jains@theoutdoorplus.com', 'Lopez', 'ADMIN', 1),
	('475d57b8-9842-4a37-be05-2a5527efac99', 'Rodrigo', 'rodrigo@theoutdoorplus.com', 'Alvarenga', 'ADMIN', 1),
	('6029384c-bf78-44a3-8cae-de4e07a9bd6c', 'Liz', 'liz@theoutdoorplus.com', 'Nuñez', 'MANAGER', 1),
	('a41f3520-5ffc-4d5f-966e-b3e6bfdccf28', 'Joseph', 'joe@theoutdoorplus.com', 'Estrada', 'ADMIN', 1),
	('40db71eb-68d2-402a-ae3f-6bd099418409', 'Distributor', 'distributor@topdashboard.com', 'Account', 'DISTRIBUTOR', 3),
	('6a2f3947-757e-4808-b260-7142b73bef33', 'Ivan', 'ivan@theoutdoorplus.com', 'Adame', 'ADMIN', 1);


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."product" ("id", "sku", "burner_shape", "compatible_canvas_cover", "compatible_bullet_burner", "compatible_glass_wind_guard", "access_door", "collection_id", "category_id", "shape_id", "product_serial_base", "certifications", "published", "enabled", "created_by", "updated_by", "company_division", "updated_at", "created_at", "name", "short_description", "description", "product_type", "website_link", "meta", "product_meta", "material_id", "dealer_price", "distributor_price", "group_price", "internet_price", "landscape_price", "map_price", "master_distributor_price", "msrp_price") VALUES
	(2, 'TEST-SKU', NULL, NULL, NULL, NULL, false, 7, 52, 12, NULL, '{LC,UL,CSA}', true, true, '475d57b8-9842-4a37-be05-2a5527efac99', '475d57b8-9842-4a37-be05-2a5527efac99', 'THE OUTDOOR PLUS', '2024-04-16 16:06:35.754098+00', '2023-12-07 22:09:48.679211+00', 'TEST PRODUCT', NULL, NULL, 'VARIABLE', NULL, NULL, NULL, NULL, 15645, 13299, 14394, 17210, 18774, 28788, 12516, 31667),
	(11, 'OPT-CORGFRC', 'SwitchBack', NULL, NULL, NULL, false, 83, 27, 13, NULL, '{CSA,LC}', false, true, '475d57b8-9842-4a37-be05-2a5527efac99', '475d57b8-9842-4a37-be05-2a5527efac99', 'The Outdoor Plus', '2024-04-16 23:29:30.81727+00', '2024-04-16 21:36:36.760391+00', 'Del Mar Fire Pit', NULL, '', 'VARIABLE', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', NULL, NULL, NULL, 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272),
	(12, 'OPT-OIL20', NULL, NULL, NULL, NULL, false, NULL, NULL, NULL, NULL, '{}', false, true, '2e69f583-266e-4ef6-9202-cda8af9a9884', '2e69f583-266e-4ef6-9202-cda8af9a9884', 'The Outdoor Plus', '2024-04-17 17:35:25.883992+00', '2024-04-17 17:35:04.947152+00', 'Oil Based Torch Head', 'It is a Oil Based Torch Head made from metal.', 'It is a Oil Based Torch Head made from metal.', 'VARIABLE', NULL, NULL, NULL, NULL, 49, 42, 46, 54, 59, 92, 40, 102);


--
-- Data for Name: variation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."variation" ("id", "parent_id", "sku", "upc_codes", "encoded_upc_codes", "product_length", "product_diameter", "product_width", "product_height", "base_length", "base_diameter", "base_width", "base_opening", "toe_kick", "soil_usage", "scupper_width", "scupper_inlet_opening", "gpm", "fire_glass", "ba_length", "ba_diameter", "ba_width", "ba_depth", "burner_shape", "burner_length", "burner_diameter", "compatible_canvas_cover", "compatible_bullet_burner", "compatible_glass_wind_guard", "product_serial_base", "certifications", "enabled", "created_by", "updated_by", "updated_at", "created_at", "name", "short_description", "description", "website_link", "meta", "product_meta", "dealer_price", "distributor_price", "group_price", "internet_price", "landscape_price", "map_price", "master_distributor_price", "msrp_price", "btu") VALUES
	(8, 11, 'OPT-CORGFRC48-BLK-NG', '196111258017', 'V(b96111*MPSKLr(w', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:37.767817+00', '2024-04-16 22:23:25.614839+00', 'Del Mar Fire Pit - 48" - Match Lit - Black - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(25, 11, 'OPT-CORGFRC60-ASH-NG', '', '', NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'SwitchBack', '', '', NULL, NULL, NULL, '', '{CSA,LC}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 22:04:30.484353+00', '2024-04-18 22:04:30.484353+00', 'Del Mar Fire Pit - 60" - Match Lit - Ash - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 2000, 1700, 1840, 2200, 2400, 3680, 1600, 4048, NULL),
	(10, 11, 'OPT-CORGFRC48-CST-NG', '196111333455', 'V(b96111*NNNOPp(u', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:36.207491+00', '2024-04-16 22:29:59.096038+00', 'Del Mar Fire Pit - 48" - Match Lit - Chestnut - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(9, 11, 'OPT-CORGFRC48-BRN-NG', '196111258031', 'V(b96111*MPSKNl(V', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:36.971174+00', '2024-04-16 22:26:28.942325+00', 'Del Mar Fire Pit - 48" - Match Lit - Brown - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(12, 11, 'OPT-CORGFRC48-GRY-NG', '196111258024', 'V(b96111*MPSKMo(Y', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:34.652121+00', '2024-04-16 22:36:19.923949+00', 'Del Mar Fire Pit - 48" - Match Lit - Gray - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(7, 11, 'OPT-CORGFRC48-ASH-NG', '196111258079', 'V(b96111*MPSKRt(y', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:33.444706+00', '2024-04-16 21:51:40.108232+00', 'Del Mar Fire Pit - 48" - Match Lit - Ash - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/?attribute_pa_ignition-type=match-lit-ignition&attribute_pa_color=ash-ash&attribute_pa_gas-type=natural-gas', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(6, 2, 'TEST-SKU-(XX)-(XX)', '', '', NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', '{LC,UL,CSA}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:34.072683+00', '2024-04-16 18:16:37.760218+00', 'TEST PRODUCT - VARIATION 1', '', '', '', '{}', '{}', 78654, 66856, 72362, 86520, 94385, 144724, 62924, 159197, 65000),
	(14, 11, 'OPT-CORGFRC48-VAN-NG', '196111258062', 'V(b96111*MPSKQm(W', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:32.002961+00', '2024-04-16 23:01:38.212577+00', 'Del Mar Fire Pit - 48" - Match Lit - Vanilla - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(18, 11, 'OPT-CORGFRC48-MSV-NG', '196111333530', 'V(b96111*NNNPNk(U', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:30.471293+00', '2024-04-17 15:41:54.397465+00', 'Del Mar Fire Pit - 48" - Match Lit - Metallic Silver - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1789, 1521, 1646, 1968, 2147, 3292, 1432, 3622, 65000),
	(19, 11, 'OPT-CORGFRC48E12V-ASH-NG', '196111205936', 'V(b96111*MKPTNq(v', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{CSA}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:28.900936+00', '2024-04-17 16:01:07.504363+00', 'Del Mar Fire Pit - 48" - Electronic Ignition - Ash - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 2812, 2391, 2588, 3094, 3375, 5176, 2250, 5694, 65000),
	(16, 11, 'OPT-CORGFRC48-RGR-NG', '196111333615', 'V(b96111*NNNQLp(u', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:22.668013+00', '2024-04-16 23:20:06.05129+00', 'Del Mar Fire Pit - 48" - Match Lit - Rustic Gray - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1789, 1521, 1646, 1968, 2147, 3292, 1432, 3622, 65000),
	(23, 2, 'TEST-SKU-(XX)-(XX)-2', '', '', NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', '{LC,UL,CSA}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:26.840601+00', '2024-04-17 16:45:47.702029+00', 'TEST PRODUCT - VARIATION 2', '', '', '', '{}', '{}', 2500, 2125, 2300, 2750, 3000, 4600, 2000, 5060, 65000),
	(24, 2, 'TEST-SKU-(XX)-(XX)-123', '', '', NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', '{LC,UL,CSA}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:27.518917+00', '2024-04-17 16:46:12.992936+00', 'TEST PRODUCT - VARIATION 3', '', '', '', '{}', '{}', 15463, 13144, 14226, 17010, 18556, 28452, 12371, 31298, 65000),
	(20, 11, 'OPT-CORGFRC48E12V-ASH-LP', '196111206117', 'V(b96111*MKQLLr(w', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{CSA}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:28.209803+00', '2024-04-17 16:08:26.716222+00', 'Del Mar Fire Pit - 48" - Electronic Ignition - Ash - Liquid Propane', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 2812, 2391, 2588, 3094, 3375, 5176, 2250, 5694, 65000),
	(17, 11, 'OPT-CORGFRC48-RCF-NG', '196111333592', 'V(b96111*NNNPTm(W', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:29.758576+00', '2024-04-17 15:39:00.014819+00', 'Del Mar Fire Pit - 48" - Match Lit - Rustic Coffee - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1789, 1521, 1646, 1968, 2147, 3292, 1432, 3622, 65000),
	(13, 11, 'OPT-CORGFRC48-NGY-NG', '196111333578', 'V(b96111*NNNPRs(x', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:31.127104+00', '2024-04-16 22:39:10.261896+00', 'Del Mar Fire Pit - 48" - Match Lit - Natural Gray - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(15, 11, 'OPT-CORGFRC48-LIM-NG', '196111258055', 'V(b96111*MPSKPp(u', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:32.769379+00', '2024-04-16 23:03:59.502291+00', 'Del Mar Fire Pit - 48" - Match Lit - Limestone - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000),
	(11, 11, 'OPT-CORGFRC48-CHC-NG', '196111258048', 'V(b96111*MPSKOs(x', '48"', NULL, '28"', '15"', '38"', '', '18"', '', '', '', '', '', '', '', '38"', '', '12"', '2"', 'SwitchBack', '24"', '', NULL, NULL, NULL, '', '{}', true, '475d57b8-9842-4a37-be05-2a5527efac99', NULL, '2024-04-18 16:36:35.502229+00', '2024-04-16 22:33:09.531831+00', 'Del Mar Fire Pit - 48" - Match Lit - Chocolate - Natural Gas', '', '', 'https://theoutdoorplus.com/product/del-mar-fire-pit-gfrc-concrete-48-inch/', '{}', '{}', 1616, 1374, 1487, 1778, 1940, 2974, 1293, 3272, 65000);


--
-- Data for Name: dealer_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: distributor_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."documents" ("id", "url", "name") VALUES
	(7, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(15, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(8, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(9, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(10, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(11, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(12, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(14, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(13, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(17, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(16, 'https://www.dropbox.com/scl/fi/fr9irmjj0czppo5edxx24/General-Fire-Pit-Manual-2019.pdf?rlkey=4xlck9hrodac4acp5wv2bvinf&dl=0', 'Manual - Match Lit Ignition'),
	(18, 'https://www.dropbox.com/scl/fi/c5d2r1cs0rzc1t7v63yzx/The-Outdoor-Plus-Low-Voltage-APPROVED-ENG.pdf?rlkey=pw7dvf601y45hm7ykpyta98o0&dl=0', 'Manual - Low Voltage (ENG)'),
	(19, 'https://www.dropbox.com/scl/fi/c5d2r1cs0rzc1t7v63yzx/The-Outdoor-Plus-Low-Voltage-APPROVED-ENG.pdf?rlkey=pw7dvf601y45hm7ykpyta98o0&dl=0', 'Manual - Low Voltage (ENG)'),
	(1, 'https://www.dropbox.com/scl/fi/o0eoy7xlubc92ilptchnr/The-Outdoor-Plus-Low-Voltage-APPROVED-FR.pdf?rlkey=0qrk85wqvy86x6cfqztupmpwm&dl=0', 'Manual - Low Voltage (FR)'),
	(20, '', '');


--
-- Data for Name: group_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."image" ("id", "url", "name") VALUES
	(26, 'https://www.dropbox.com/scl/fi/ievcjl4c05koe4o1u9uo3/Del-Mar-Fire-Pit-Chestnut.jpg?rlkey=tyv34rkbzozk73lzvfnujeb1j&raw=1', 'Del Mar Fire Pit'),
	(38, 'https://www.dropbox.com/scl/fi/6rcf4u8acn4nvtaktdbm6/Del-Mar-Fire-Pit-Natural-Gray.jpg?rlkey=rfi5459zho34q83cmhizjl4ro&dl=0', 'Del Mar Fire Pit - GFRC Natural Gray'),
	(3, 'https://www.dropbox.com/scl/fi/aaqoxm0ujxa90m4k92ycf/Del-Mar-Limestone-60-2.jpg?rlkey=2m651fq7ftebf3ctpbnq9xmsn&dl=0', 'Lifestyle - Del Mar Fire Pit - GFRC Limestone - 60"'),
	(31, 'https://www.dropbox.com/scl/fi/0rpx4wh8hibw3ohoe49g9/Del-Mar-Fire-Pit-Limestone.jpg?rlkey=2zaf3qke8ftv0n9z6iz4xcyft&dl=0', 'Del Mar Fire Pit - GFRC Limestone'),
	(2, 'https://www.dropbox.com/scl/fi/ng4m1jjo7zax6getzg67r/Del-Mar-48-Limestone-2.jpg?rlkey=8l9ktnwamw405zr5g9h4bo07g&dl=0', 'Lifestyle - Del Mar Fire Pit - GFRC Limestone - 48"'),
	(1, 'https://www.dropbox.com/scl/fi/k7rwxi4pew3pba80b8z2z/Del-Mar-GFRC-Concrete-Brown-El-Mirage-Lifestyle-005.jpg?rlkey=xr3z34lbv8gqpaw2j05p3c248&dl=0', 'Lifestyle - Del Mar Fire Pit - GFRC Brown'),
	(41, 'https://www.dropbox.com/scl/fi/aoqvullyyw4f66a81wx5q/Del-Mar-Fire-Pit-Ash.jpg?rlkey=g700jqapctbmth1wdtwiib2cd&dl=0', 'Del Mar Fire Pit - Ash'),
	(42, '', ''),
	(30, 'https://www.dropbox.com/scl/fi/mvmmvxrq0ze9oyofayj4r/Cazo-Planter-Bowl-black.jpg?rlkey=lq44sqtaqtwje1u21oxjggh2r&dl=0', 'Cazo Planter Bowl - Black'),
	(27, 'https://theoutdoorplus.com/wp-content/uploads/2024/02/TOP_LOGO_BlackOrange.svg', 'Test'),
	(29, 'https://www.dropbox.com/scl/fi/7ydaf7ltbjnl09pea5ch1/Cazo-Planter-Bowl-ash.jpg?rlkey=aexk0mh3lw0nwfhuexnn5e51u&dl=0', 'Cazo Planter Bowl - Ash'),
	(28, 'https://www.dropbox.com/scl/fi/robl9mzcseod7ojzz8ugw/Cazo-Planter-Bowl.png?rlkey=g9ktitov6a0r9a24wn8pahq0w&dl=0', 'Cazo Planter'),
	(32, 'https://www.dropbox.com/scl/fi/aoqvullyyw4f66a81wx5q/Del-Mar-Fire-Pit-Ash.jpg?rlkey=g700jqapctbmth1wdtwiib2cd&dl=0', 'Del mar Fire Pit - GFRC Ash'),
	(33, 'https://www.dropbox.com/scl/fi/q8k7hcrc5nlgwpptud06a/Del-Mar-Fire-Pit-Black.jpg?rlkey=z9tyl6v861j4l2obzsdcv60jf&dl=0', 'Del Mar Fire Pit - GFRC Black'),
	(34, 'https://www.dropbox.com/scl/fi/j63zivmzia1sqejs3xlcj/Del-Mar-Fire-Pit-Brown.jpg?rlkey=9wywvck4x30zj15pennwlzzj8&dl=0', 'Del Mar Fire Pit - GFRC Brown'),
	(35, 'https://www.dropbox.com/scl/fi/9ht1fopmpc8tmsr2wbsc0/Del-Mar-Fire-Pit-Chestnut.jpg?rlkey=pqikvlc6xxxsfg9eo5l35362j&dl=0', 'Del mar Fire Pit - GFRC Chestnut'),
	(36, 'https://www.dropbox.com/scl/fi/m204mmjx8w20tofood4bo/Del-Mar-Fire-Pit-Chocolate.jpg?rlkey=zdsda4pqk2uhwdzl2vdunvson&dl=0', 'Del Mar Fire Pit - GFRC Chocolate'),
	(37, 'https://www.dropbox.com/scl/fi/ouyh9n3hr7ffieyqp44ky/Del-Mar-Fire-Pit-Gray.jpg?rlkey=yqbe7kytb4opidqwru1z6k5bs&dl=0', 'Del Mar Fire Pit - GFRC Gray'),
	(39, 'https://www.dropbox.com/scl/fi/0rpx4wh8hibw3ohoe49g9/Del-Mar-Fire-Pit-Limestone.jpg?rlkey=2zaf3qke8ftv0n9z6iz4xcyft&dl=0', 'Del Mar Fire Pit - GFRC Limestone'),
	(40, 'https://www.dropbox.com/scl/fi/az7dbkycxjypq7m1g2x6y/Del-Mar-Fire-Pit-Vanilla.jpg?rlkey=g7ioe4cofezofqfxnz5csugb2&dl=0', 'Del Mar Fire Pit - GFRC Vanilla');


--
-- Data for Name: internet_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: landscape_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: map_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: master_distributor_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: msrp_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."product_attribute" ("id", "product_id", "attribute_id", "fill_values") VALUES
	(34, 2, 3, false),
	(35, 2, 14, false),
	(36, 2, 4, false),
	(37, 11, 1, false),
	(38, 11, 14, false),
	(39, 11, 4, false),
	(40, 11, 2, true),
	(41, 11, 3, false),
	(42, 12, 14, false),
	(43, 12, 2, false),
	(44, 12, 4, false),
	(45, 12, 3, false);


--
-- Data for Name: product_color; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product_configuration; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."product_configuration" ("product_id", "value_id") VALUES
	(2, 86),
	(2, 10),
	(2, 88),
	(2, 9),
	(11, 99),
	(11, 10),
	(11, 98),
	(11, 42),
	(11, 41),
	(11, 97),
	(11, 94),
	(11, 96),
	(11, 85),
	(11, 93),
	(11, 92),
	(11, 86),
	(11, 90),
	(12, 10),
	(12, 74),
	(12, 87),
	(12, 28);


--
-- Data for Name: product_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."product_documents" ("product_id", "document_id") VALUES
	(12, 20);


--
-- Data for Name: product_gas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product_ignition; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."product_image" ("product_id", "image_id", "display_order", "is_primary") VALUES
	(12, 42, 0, false),
	(11, 3, 3, false),
	(11, 31, 0, true),
	(11, 1, 1, false),
	(11, 2, 2, false);


--
-- Data for Name: product_material; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: specification_sheet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."specification_sheet" ("id", "url", "name") VALUES
	(21, 'https://www.dropbox.com/scl/fi/2hvpkq7buyr2aiydq4a74/Del-Mar-GFRC-Fire-Pit-Spec-Sheets.pdf?rlkey=ybnta35iu2unhv8ueqtsa1mlh&dl=0', 'Del Mar Fire Pit GFRC Spec Sheet'),
	(22, 'https://www.dailynews.com/2024/04/17/battle-intensifies-over-new-monthly-fee-planned-for-californians-power-bills/', 'Spec');


--
-- Data for Name: product_specification_sheet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."product_specification_sheet" ("product_id", "specification_sheet_id") VALUES
	(11, 21),
	(12, 22);


--
-- Data for Name: variation_configuration; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."variation_configuration" ("variation_id", "value_id", "attribute_id") VALUES
	(12, 85, 1),
	(12, 52, 2),
	(12, 10, 3),
	(12, 42, 4),
	(12, 86, 14),
	(15, 10, 3),
	(15, 86, 14),
	(15, 85, 1),
	(15, 42, 4),
	(15, 53, 2),
	(14, 10, 3),
	(14, 61, 2),
	(14, 85, 1),
	(14, 86, 14),
	(14, 42, 4),
	(13, 10, 3),
	(13, 85, 1),
	(13, 55, 2),
	(13, 42, 4),
	(13, 86, 14),
	(18, 42, 4),
	(18, 10, 3),
	(18, 59, 2),
	(6, 86, 14),
	(6, 9, 4),
	(6, 10, 3),
	(18, 86, 14),
	(18, 85, 1),
	(17, 50, 2),
	(7, 10, 3),
	(7, 45, 2),
	(7, 85, 1),
	(7, 86, 14),
	(7, 42, 4),
	(17, 10, 3),
	(17, 86, 14),
	(17, 42, 4),
	(17, 85, 1),
	(19, 86, 14),
	(16, 57, 2),
	(16, 42, 4),
	(16, 86, 14),
	(16, 10, 3),
	(16, 85, 1),
	(8, 85, 1),
	(8, 46, 2),
	(8, 86, 14),
	(8, 10, 3),
	(8, 42, 4),
	(9, 85, 1),
	(9, 10, 3),
	(9, 86, 14),
	(9, 42, 4),
	(9, 62, 2),
	(10, 10, 3),
	(10, 86, 14),
	(10, 85, 1),
	(10, 42, 4),
	(10, 48, 2),
	(11, 85, 1),
	(11, 49, 2),
	(11, 10, 3),
	(11, 86, 14),
	(11, 42, 4),
	(19, 42, 4),
	(19, 98, 3),
	(19, 85, 1),
	(19, 45, 2),
	(20, 98, 3),
	(20, 42, 4),
	(20, 86, 14),
	(20, 41, 1),
	(20, 45, 2),
	(24, 88, 14),
	(24, 10, 3),
	(24, 9, 4),
	(23, 10, 3),
	(23, 86, 14),
	(23, 9, 4),
	(25, 42, 4),
	(25, 85, 1),
	(25, 45, 2),
	(25, 10, 3),
	(25, 92, 14);


--
-- Data for Name: variation_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."variation_documents" ("variation_id", "document_id") VALUES
	(7, 7),
	(16, 15),
	(8, 8),
	(9, 9),
	(10, 10),
	(11, 11),
	(12, 12),
	(14, 14),
	(13, 13),
	(18, 17),
	(17, 16),
	(19, 1),
	(19, 18),
	(20, 19),
	(20, 1);


--
-- Data for Name: variation_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."variation_image" ("variation_id", "image_id", "display_order", "is_primary") VALUES
	(7, 32, 0, true),
	(8, 33, 0, true),
	(9, 34, 0, true),
	(10, 35, 0, true),
	(11, 36, 0, true),
	(12, 37, 0, true),
	(15, 39, 0, true),
	(14, 40, 0, true),
	(13, 38, 0, true),
	(19, 41, 0, true);


--
-- Data for Name: variation_specification_sheet; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--



--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 438, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('"pgsodium"."key_key_id_seq"', 1, false);


--
-- Name: attribute_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."attribute_value_id_seq"', 102, true);


--
-- Name: attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."attributes_id_seq"', 16, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."category_id_seq"', 73, true);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."collection_id_seq"', 184, true);


--
-- Name: color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."color_id_seq"', 65, true);


--
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."company_id_seq"', 3, true);


--
-- Name: dealer_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."dealer_price_id_seq"', 3, true);


--
-- Name: distributor_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."distributor_price_id_seq"', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."documents_id_seq"', 20, true);


--
-- Name: gas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."gas_id_seq"', 8, true);


--
-- Name: group_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."group_price_id_seq"', 1, false);


--
-- Name: ignition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."ignition_id_seq"', 13, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."image_id_seq"', 42, true);


--
-- Name: internet_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."internet_price_id_seq"', 12, true);


--
-- Name: landscape_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."landscape_price_id_seq"', 1, false);


--
-- Name: map_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."map_price_id_seq"', 5, true);


--
-- Name: master_distributor_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."master_distributor_price_id_seq"', 1, false);


--
-- Name: material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."material_id_seq"', 35, true);


--
-- Name: msrp_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."msrp_price_id_seq"', 3, true);


--
-- Name: product_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."product_attribute_id_seq"', 45, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."product_id_seq"', 12, true);


--
-- Name: product_specification_sheet_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."product_specification_sheet_product_id_seq"', 1, false);


--
-- Name: shape_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."shape_id_seq"', 13, true);


--
-- Name: specification_sheet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."specification_sheet_id_seq"', 22, true);


--
-- Name: variation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."variation_id_seq"', 25, true);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

RESET ALL;
