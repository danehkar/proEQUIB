; Example: getabundance()
;     determine ionic abundance from observed 
;     flux intensity for gievn electron density 
;     and temperature using  getabundance function
;     from proEQUIB
; 
; --- Begin $MAIN$ program. ---------------
; 
; 
Atom_Elj_file='/AtomNeb/atomic-data/chianti70/AtomElj.fits'
Atom_Omij_file='/AtomNeb/atomic-data/chianti70/AtomOmij.fits'
Atom_Aij_file='/AtomNeb/atomic-data/chianti70/AtomAij.fits'
Atom_RC_SH95_file='/AtomNeb/atomic-data-rc/rc_SH95.fits'

atom='h'
ion='ii' ; H I Rec
hi_rc_data=atomneb_read_aeff_sh95(Atom_RC_SH95_file, atom, ion)

atom='o'
ion='iii' ; [O III]
o_iii_elj=atomneb_read_elj(Atom_Elj_file, atom, ion, level_num=5) ; read Energy Levels (Ej) 
o_iii_omij=atomneb_read_omij(Atom_Omij_file, atom, ion) ; read Collision Strengths (Omegaij)
o_iii_aij=atomneb_read_aij(Atom_Aij_file, atom, ion) ; read Transition Probabilities (Aij)

levels5007='3,4/'
tempi=double(10000.0)
densi=double(5000.0)
iobs5007=double(1200.0)
Abb5007=double(0.0) 

Abb5007=calc_abundance(o_iii_elj, o_iii_omij, o_iii_aij, hi_rc_data[0].Aeff, levels5007, tempi, densi, iobs5007)

print, Abb5007

end 
