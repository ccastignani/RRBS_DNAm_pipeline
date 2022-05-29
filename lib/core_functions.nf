///////////////////////////////////////////////////////////////////////////
/* -----------       Core functions for DNAm pipeline        ----------- */
///////////////////////////////////////////////////////////////////////////
// Get the GIT commit ID for the current run
commit_id = "git log -n1 --format=format:%H".execute().in.text ?: workflow.commitId
date = new Date()

def logo() {
    out="""
    =================================================
    ###### ###### ###### ###### ###### ###### ##   ##
      ##   ##  ## ##  ## ##     ##     ##  ##  ## ##
      ##   ####   ###### ##     #####  ####     ###
      ##   ## ##  ##  ## ##     ##     ## ##   ## ##
      ##   ##  ## ##  ## ###### ###### ##  ## ##   ##
    =================================================
    <<<<<<<<<<   NUGEN RRBS DNAm Pipeline   >>>>>>>>>
    =================================================
    """.stripIndent()
    out
}

def helpMessage() {
    out = logo()
    out += '''
    Usage:
        nextflow run -profile local --input <inventory.tsv> --outdir <path> main.nf
    Mandatory arguments:
      -profile                      Configuration profile to use
      --input                       The inventory file
      --outdir                      Directory to publish results
    '''.stripIndent()
    log.info(out)
}

def outputSummary() {
    out = logo()
    out += """
    parameter             value
    ---------             -------------------
    profile               ${workflow.profile}
    run                   ${workflow.runName}
    session               ${workflow.sessionId}
    commitId              ${commit_id}
    user                  ${"whoami".execute().in.text.strip()}
    date                  ${date.format("YYYY-MM-dd HH:mm:ss.Ms")}
    command               ${workflow.commandLine}
    Input                 ${params.input}
    OutDir                ${params.outdir}
    WorkDir               ${params.workdir}
    =============================================
    """.stripIndent()
    log.info(out)
    out
}
