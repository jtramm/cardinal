$(OPENMC_BUILDDIR)/Makefile: build_dagmc | $(OPENMC_DIR)/CMakeLists.txt
	mkdir -p $(OPENMC_BUILDDIR)
	cd $(OPENMC_BUILDDIR) && \
	cmake --preset=llvm_a100_mpi -L \
	-DDAGMC_DIR=$(DAGMC_DIR) \
	-DCMAKE_PREFIX_PATH=$(LIBMESH_DIR) \
	-DCMAKE_INSTALL_PREFIX=$(OPENMC_INSTALL_DIR) \
	-DCMAKE_INSTALL_LIBDIR=$(OPENMC_LIBDIR) \
	-DCMAKE_CXX_STANDARD=17 \
	-DCMAKE_INSTALL_MESSAGE=LAZY \
	$(OPENMC_DIR)

build_openmc: | $(OPENMC_BUILDDIR)/Makefile
	#make VERBOSE=1 -C $(OPENMC_BUILDDIR) install

cleanall_openmc: | $(OPENMC_BUILDDIR)/Makefile
	make -C $(OPENMC_BUILDDIR) uninstall clean

clobber_openmc:
	rm -rf $(OPENMC_LIB) $(OPENMC_BUILDDIR) $(OPENMC_INSTALL_DIR)

cleanall: cleanall_openmc

clobberall: clobber_openmc

.PHONY: build_openmc cleanall_openmc clobber_openmc
