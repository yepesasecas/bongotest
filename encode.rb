require "base64"
require 'nokogiri'

encoded  = "PD94bWwgdmVyc2lvbj0iMS4wIj8+DQo8cnNzIHZlcnNpb249IjIuMCI+PGNoYW5uZWw+PGxpbmsvPjxkZXNjcmlwdGlvbj5PcmRlciB0byB2ZXJpZnk8L2Rlc2NyaXB0aW9uPjxsYW5ndWFnZT5lbi1lbjwvbGFuZ3VhZ2U+PGNvcHlyaWdodD5ib25nb3VzLmNvbTwvY29weXJpZ2h0PjxpdGVtPjxpZG9yZGVyPjEyNTU2MzwvaWRvcmRlcj48dHJhY2tpbmdsaW5rPmh0dHBzOi8vYm9uZ291cy5jb20vdHJhY2tpbmcvUzIzNjctODQzNTA5QzU2TTE0TjQxUjwvdHJhY2tpbmdsaW5rPg0KPGN1c3RvbWVyZmlyc3RuYW1lPjwhW0NEQVRBW1Rlc3RdXT48L2N1c3RvbWVyZmlyc3RuYW1lPg0KPGN1c3RvbWVybGFzdG5hbWU+PCFbQ0RBVEFbVGVzdGVyXV0+PC9jdXN0b21lcmxhc3RuYW1lPg0KPGNvbXBhbnk+PCFbQ0RBVEFbXV0+PC9jb21wYW55Pg0KPGN1c3RvbWVyYWRkcmVzMT48IVtDREFUQVsxMjMgVGVzdCBBdmVdXT48L2N1c3RvbWVyYWRkcmVzMT4NCjxjdXN0b21lcmFkZHJlczI+PCFbQ0RBVEFbXV0+PC9jdXN0b21lcmFkZHJlczI+DQo8Y3VzdG9tZXJjaXR5PjwhW0NEQVRBW090dGF3YV1dPjwvY3VzdG9tZXJjaXR5Pg0KPGN1c3RvbWVyY291bnRyeT48IVtDREFUQVtVU11dPjwvY3VzdG9tZXJjb3VudHJ5Pg0KPGN1c3RvbWVyc3RhdGU+PCFbQ0RBVEFbRmxvcmlkYV1dPjwvY3VzdG9tZXJzdGF0ZT4NCjxjdXN0b21lcnppcD48IVtDREFUQVszMzcxNl1dPjwvY3VzdG9tZXJ6aXA+DQo8Y3VzdG9tZXJwaG9uZT48IVtDREFUQVsyMzQtNTY3LTg5MTBdXT48L2N1c3RvbWVycGhvbmU+DQo8Y3VzdG9tZXJlbWFpbD48IVtDREFUQVtleGFtcGxlLnRlc3RAZXhhbXBsZS5jb21dXT48L2N1c3RvbWVyZW1haWw+DQo8cHJvZHVjdHM+PGl0ZW1wcm9kdWN0cz48cHJvZHVjdGlkPjwhW0NEQVRBWzA3LjAyLk9MXV0+PC9wcm9kdWN0aWQ+DQo8cXR5PjE8L3F0eT4NCjxwcmljZT4xPC9wcmljZT4NCjxTS1VEaXN0cmlidXRpb25Db3VudHJ5PjwhW0NEQVRBW1VTXV0+PC9TS1VEaXN0cmlidXRpb25Db3VudHJ5Pg0KPFNLVURpc3RyaWJ1dGlvbkNvdW50cnlaSVA+PCFbQ0RBVEFbXV0+PC9TS1VEaXN0cmlidXRpb25Db3VudHJ5WklQPg0KPGN1c3RvbV8xPjwhW0NEQVRBW11dPjwvY3VzdG9tXzE+DQo8Y3VzdG9tXzI+PCFbQ0RBVEFbXV0+PC9jdXN0b21fMj4NCjxjdXN0b21fMz48IVtDREFUQVtdXT48L2N1c3RvbV8zPg0KPC9pdGVtcHJvZHVjdHM+PC9wcm9kdWN0cz4NCjxzaGlwYWRkcmVzczE+PCFbQ0RBVEFbMTA5MDEgUm9vc2V2ZWx0IEJsdmQuIFN0ZS4gMTAwMF1dPjwvc2hpcGFkZHJlc3MxPg0KPHNoaXBhZGRyZXNzMj4jIDgwNzM2PC9zaGlwYWRkcmVzczI+DQo8c2hpcGNpdHk+PCFbQ0RBVEFbU3QuIFBldGVyc2J1cmddXT48L3NoaXBjaXR5Pg0KPHNoaXBzdGF0ZT48IVtDREFUQVtGTF1dPjwvc2hpcHN0YXRlPg0KPHNoaXB6aXA+PCFbQ0RBVEFbMzM3MTZdXT48L3NoaXB6aXA+DQo8c2hpcGNvdW50cnk+PCFbQ0RBVEFbVVNdXT48L3NoaXBjb3VudHJ5Pg0KPHNoaXBwaG9uZT48IVtDREFUQVs2NDYuNDkwLjI2OTFdXT48L3NoaXBwaG9uZT4NCjxzaGlwSU5UTGFkZHJlc3MxPiA8IVtDREFUQVsxMjMgRXhhbXBsZSBBdmVdXT4gPC9zaGlwSU5UTGFkZHJlc3MxPg0KPHNoaXBJTlRMYWRkcmVzczI+IDwhW0NEQVRBW0FQVCAxMjNdXT4gPC9zaGlwSU5UTGFkZHJlc3MyPg0KPHNoaXBJTlRMY2l0eT48IVtDREFUQVtQYXJpc11dPjwvc2hpcElOVExjaXR5Pg0KPHNoaXBJTlRMc3RhdGU+PCFbQ0RBVEFbSWxsIGRlIEZyYW5jZV1dPjwvc2hpcElOVExzdGF0ZT4NCjxzaGlwSU5UTHppcD48IVtDREFUQVs3NzAxXV0+PC9zaGlwSU5UTHppcD4NCjxzaGlwSU5UTGNvdW50cnk+PCFbQ0RBVEFbRlJdXT48L3NoaXBJTlRMY291bnRyeT4NCjxzaGlwSU5UTHBob25lPjwhW0NEQVRBWzU4LjQ0NC40OTAuMjY5MV1dPjwvc2hpcElOVExwaG9uZT4NCjxvcmRlcnN1YnRvdGFsPjUuMDAwMDAwMDAwMDwvb3JkZXJzdWJ0b3RhbD4NCjxvcmRlcmR1dHljb3N0PjAuMDA8L29yZGVyZHV0eWNvc3Q+DQo8b3JkZXJ0YXhjb3N0PjAuMDA8L29yZGVydGF4Y29zdD4NCjxvcmRlcnNoaXBwaW5nY29zdD4yNi4zMjwvb3JkZXJzaGlwcGluZ2Nvc3Q+DQo8b3JkZXJzaGlwcGluZ2Nvc3Rkb21lc3RpYz4wLjAwMDAwMDAwMDA8L29yZGVyc2hpcHBpbmdjb3N0ZG9tZXN0aWM+DQo8b3JkZXJpbnN1cmFuY2Vjb3N0PjAuMzk8L29yZGVyaW5zdXJhbmNlY29zdD4NCjxzZXR0bGVjdXJyZW5jeT5VU0Q8L3NldHRsZWN1cnJlbmN5ID4NCjxvcmRlcmN1cnJlbmN5Y29kZT4gRVVSPC9vcmRlcmN1cnJlbmN5Y29kZSA+DQo8b3JkZXJjdXJyZW5jeXJhdGU+Ljc0ODc8L29yZGVyY3VycmVuY3lyYXRlID4NCjxwYXltZW50dHlwZT5NQVNURVJDQVJEPC9wYXltZW50dHlwZT4NCjxpbmNvdGVybT5ERFU8L2luY290ZXJtPg0KPHNlcnZpY2VsZXZlbD5FY29ub215IDwvc2VydmljZWxldmVsPg0KPGludGxFVEE+MjAxNC0wMi0yNTwvaW50bEVUQT4NCjxDdXN0b21lclNlcnZpY2U+VGhpcyBpcyBhIHRlc3Qgbm90ZS48L0N1c3RvbWVyU2VydmljZT4NCjxvcmRlcnRvdGFsPjMxLjcxPC9vcmRlcnRvdGFsPjxjdXN0b21fb3JkZXIxPg0KPCFbQ0RBVEFbXV0+DQo8L2N1c3RvbV9vcmRlcjE+PGN1c3RvbV9vcmRlcjI+DQo8IVtDREFUQVtdXT4NCjwvY3VzdG9tX29yZGVyMj48Y3VzdG9tX29yZGVyMz4NCjwhW0NEQVRBW11dPg0KPC9jdXN0b21fb3JkZXIzPjxvcmRlcmxhbmRlZENvc3RUcmFuc2FjdGlvbklEPjQxYzViYzFmNTVkMGE1MzEyNGFlYTYyZTc1ZDc3ODgyPC9vcmRlcmxhbmRlZENvc3RUcmFuc2FjdGlvbklEPjxwdWJEYXRlPjIwMTQtMDctMTggMDc6MjI6MTA8L3B1YkRhdGU+PC9pdGVtPjwvY2hhbm5lbD48L3Jzcz4="
decode   = Base64.decode64 encoded 
xml      = Nokogiri::XML decode
order_id = xml.children.children.children[4].children
p order_id