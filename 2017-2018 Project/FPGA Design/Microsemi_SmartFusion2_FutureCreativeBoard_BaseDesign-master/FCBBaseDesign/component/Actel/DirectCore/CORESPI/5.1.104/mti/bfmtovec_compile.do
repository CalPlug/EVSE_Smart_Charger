### script to compile Actel AMBA BFM source file into vector file for simulation
# 12Jan09		Production Release Version 3.0
quietly set linux_exe    "./bfmtovec.lin"
quietly set windows_exe  "./bfmtovec.exe"
quietly set bfm_src_in  "./user_tb.bfm"
quietly set bfm_vec_out "./user_tb.vec"
# check OS type and use appropriate executable
if {$tcl_platform(os) == "Linux"} {
	echo "--- Using Linux Actel DirectCore AMBA BFM compiler"
	quietly set bfmtovec_exe "./bfmtovec.lin"
	if {![file executable $bfmtovec_exe]} {
		quietly set cmds "chmod +x $bfmtovec_exe"
		eval $cmds
	}
} else {
	echo "--- Using Windows Actel DirectCore AMBA BFM compiler"
	quietly set bfmtovec_exe "./bfmtovec.exe"
}
# compile BFM source files into vector outputs
echo "--- Compiling Actel DirectCore AMBA BFM source files ..."
quietly set cmd1 "exec $bfmtovec_exe -in $bfm_src_in -out $bfm_vec_out"
eval $cmd1
echo "--- Done."
