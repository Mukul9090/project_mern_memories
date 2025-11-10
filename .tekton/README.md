# Tekton Pipeline Configuration

This directory contains the Tekton PipelineRun configuration for CI/CD in OpenShift.

## Pipeline Configuration

**File**: `.tekton/push.yaml`

### Features
- ✅ Runs on **push** and **pull_request** events to `main` branch
- ✅ Clones the repository using git-clone task
- ✅ Displays repository information, file structure, and Docker configuration
- ✅ Shows detailed logs for debugging

## How to View Pipeline Logs in OpenShift

### Option 1: OpenShift Web Console

1. **Navigate to Pipelines**:
   - Go to your OpenShift project/namespace
   - Click on **"Pipelines"** in the left sidebar
   - You should see `pipelinerun-generic` runs

2. **View Pipeline Runs**:
   - Click on a pipeline run to see its details
   - You'll see all tasks (fetch-repository, show-info)
   - Click on any task to see its logs

3. **View Logs**:
   - Click on a task step (e.g., "show-info")
   - Click **"Logs"** tab to see the output
   - You should see all the echo statements and repository information

### Option 2: OpenShift CLI (oc)

```bash
# List all pipeline runs
oc get pipelineruns

# View details of a specific pipeline run
oc describe pipelinerun pipelinerun-generic-<run-id>

# View logs from a specific task
oc logs -f task/show-info-<task-id>

# Or view all logs from a pipeline run
oc logs -f pipelinerun/pipelinerun-generic-<run-id>
```

### Option 3: Tekton CLI (tkn)

```bash
# List pipeline runs
tkn pipelinerun list

# View logs of the latest pipeline run
tkn pipelinerun logs -f -L

# View logs of a specific pipeline run
tkn pipelinerun logs pipelinerun-generic-<run-id> -f
```

## Troubleshooting

### Pipeline Not Running?

1. **Check Webhook Configuration**:
   - Verify webhook is configured in GitHub
   - Webhook URL: `https://pipelines-as-code-controller-openshift-pipelines.apps.rm1.0a51.p1.openshiftapps.com`
   - Events: Push and Pull Request

2. **Check PipelineRun Status**:
   ```bash
   oc get pipelineruns
   ```
   - Look for status: `Running`, `Succeeded`, or `Failed`

3. **Check Events**:
   ```bash
   oc get events --sort-by='.lastTimestamp'
   ```

### No Logs Showing?

1. **Check if Pipeline Started**:
   ```bash
   oc get pipelineruns -o wide
   ```

2. **Check Task Status**:
   ```bash
   oc get taskruns
   ```

3. **View Task Logs Directly**:
   ```bash
   # Find the task run name
   oc get taskruns
   
   # View logs
   oc logs taskrun/<task-run-name> -c step-show-info
   ```

### Common Issues

**Issue**: Pipeline not triggering on push
- **Solution**: Verify webhook is active and events include "push"

**Issue**: Git clone fails
- **Solution**: Check if `git_auth_secret` is properly configured in OpenShift

**Issue**: No logs visible
- **Solution**: 
  - Wait a few seconds for pipeline to start
  - Check if pipeline run exists: `oc get pipelineruns`
  - View logs using CLI: `oc logs -f taskrun/<name>`

## Pipeline Output

When the pipeline runs successfully, you should see:
- Repository URL and revision
- Current directory contents
- Git information (if available)
- Docker configuration files check
- Directory structure verification

## Next Steps

To add more functionality to the pipeline:
1. Add build tasks (Docker build, npm build, etc.)
2. Add test tasks
3. Add deployment tasks
4. Add notification tasks

See Tekton documentation for more examples.

