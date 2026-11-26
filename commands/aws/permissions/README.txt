aws/permissions

/aws:permissions:walkthrough

Walks you through an AWS IAM policy file one permission at a time. For each
permission it shows the whole statement, comment included, and says what the
permission does, why it is needed, what limits it and where it is already tested.
Before the first permission it rewrites any statement comment that does not say
clearly why its permissions are needed. Say n for the next permission, or ask for a
change to the statement or its comment, and it makes the change locally and shows
the permission again.

Name the policy file by its path, its file name, or its project and environment:

    /aws:permissions:walkthrough terraform/constructionyard/policies/<file>.json
    /aws:permissions:walkthrough cloudfront_automation_api_environment_production.json
    /aws:permissions:walkthrough cfai prod

It finds the file on disk from the current directory, and asks for the path when no
file or more than one matches. It never commits or pushes.
