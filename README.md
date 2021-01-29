<!-- https://hasura.io/docs/1.0/graphql/core/migrations/config-v1/manage-migrations.html#step-4-use-the-console-from-the-cli -->

This is how you initialize version control for hasura porject:
Step 1: Install the Hasura CLI
yarn add -D hasura-cli

Step 2: Set up a project directory
hasura init my-project --endpoint http://my-graphql.hasura.app
cd my-project

In case there is an admin secret set, you can set it as an environment variable HASURA_GRAPHQL_ADMIN_SECRET=<your-admin-secret> on the local machine and the CLI will use it. You can also use it as a flag to CLI: --admin-secret '<your-admin-secret>'.

Step 3: Initialize the migrations
hasura migrate create "init" --from-server
hasura migrate apply --version "<version>" --skip-execution

Step 4: Apply the migrations on another instance
change config.yaml commented variables
yarn apply:mg => hasura migrate apply

Step 5 (optional): Apply metadata:
export metadata from remote origin using console
import metadata to local using console

