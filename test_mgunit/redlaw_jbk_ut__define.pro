function redlaw_jbk_ut::test_basic
  compile_opt strictarr
  
  wavelength=6563.0
  m_ext=1.0
  flux=1.0
  R_V=3.1

  fl=redlaw_jbk(wavelength)
  
  result= long(fl*1e4)
  assert, result eq -3311, 'incorrect result: %d', result

  return, 1
end

pro redlaw_jbk_ut__define
  compile_opt strictarr

  define = { redlaw_jbk_ut, inherits proEquibUTTestCase}
end

