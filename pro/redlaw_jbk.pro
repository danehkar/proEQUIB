; docformat = 'rst'

function redlaw_jbk, wavelength
;+
;    This function determines the reddening law function for Galactic Whitford1958 + Seaton1977 + Kaler1976.
;
; :Returns:
;    type=double/array. This function returns the reddening law function value(s) for the given wavelength(s).
;
; :Params:
;     wavelength :  in, required, type=float
;                   Wavelength in Angstrom
;
; :Examples:
;    For example::
;
;     IDL> wavelength=6563.0
;     IDL> fl=redlaw_jbk(wavelength)
;     IDL> print, 'fl(6563)', fl
;        fl(6563)     -0.33113684
;
; :Categories:
;   Interstellar Extinction
;
; :Dirs:
;  ./
;      Subroutines
;
; :Author:
;   Ashkbiz Danehkar
;
; :Copyright:
;   This library is released under a GNU General Public License.
;
; :Version:
;   0.3.0
;
; :History:
;     Based on Whitford (1958), extended to the UV by Seaton (1977), 
;     adapted by Kaler (1976).
;     
;     Originally from IRAF STSDAS SYNPHOT redlaw.x
;     
;     13/05/1993, R. A. Shaw, Initial IRAF implementation.
;     
;     31/08/2012, A. Danehkar, Converted to IDL code.
;-

;+
; NAME:
;     redlaw_jbk
; 
; PURPOSE:
;    This function determines the reddening law function for Galactic Whitford1958 + Seaton1977 + Kaler1976.
;
; CALLING SEQUENCE:
;     fl = redlaw_jbk(Wavelength)
;
; INPUTS:
;     Wavelength[] -  in, required, type=float/array, 
;               wavelength in Angstroms
;
; OUTPUTS: This function returns a double/array  as the reddening law function 
;                   value(s) f(lambda) for the given wavelength(s) lambda.
;
; PROCEDURE: This function is callsed by redlaw.
;
; EXAMPLE:
;     wavelength=6563.0
;     fl=redlaw_jbk(wavelength)
;     print, 'fl(6563)', fl
;     > fl(6563)     -0.33113684
;
; MODIFICATION HISTORY:
;     Based on Whitford (1958), extended to the UV by Seaton (1977), 
;     adapted by Kaler (1976).
;     Originally from IRAF STSDAS SYNPHOT redlaw.x
;     13/05/1993, R. A. Shaw, Initial IRAF implementation.
;     31/08/2012, A. Danehkar, Converted to IDL code.
;-

  ; Tabulated wavelengths, Angstroms:
  refw=[ 1150., 1200., 1250., 1300., 1350., 1400., 1450., 1500., 1550., $
        1600., 1650., 1700., 1750., 1800., 1850., 1900., 1950., 2000., 2050., $
        2100., 2150., 2200., 2250., 2300., 2350., 2400., 2450., 2500., 2550., $
        2600., 2650., 2700., 2750., 2800., 2850., 2900., 2950., 3000., 3050., $
        3100., 3333., 3500., 3600., 3700., 3800., 3900., 4000., 4100., 4200., $
        4300., 4400., 4500., 4600., 4700., 4800., 4861.3, 5000., 5100., 5200., $
        5300., 5400., 5500., 5600., 5700., 5800., 5900., 6000., 6100., 6200., $
        6300., 6400., 6500., 6600., 6700., 6800., 6900., 7000., 7200., 7400., $
        7600., 7800., 8000., 8200., 8400., 8600., 8800., 9000., 9500., 10000., $
        11000.,12000.,14000.,16000.,20000.,1.D+6]
        
  ; Tabulated extinction function:
  extab=[1.96,  1.78,  1.61,  1.49,  1.37,  1.29,  1.24,  1.20,  1.20, $ 
        1.20,  1.17,  1.13,  1.11,  1.10,  1.12,  1.17,  1.25,  1.35,  1.45, $
        1.53,  1.60,  1.62,  1.52,  1.40,  1.28,  1.17,  1.06,  0.98,  0.9, $
        0.84,  0.77,  0.72,  0.68,  0.64,  0.60,  0.57,  0.53,  0.51,  0.48, $
        0.46,  0.385, 0.358, 0.33,  0.306, 0.278, 0.248, 0.220, 0.195, 0.168, $
        0.143, 0.118, 0.095, 0.065, 0.040, 0.015, 0.000,-0.030,-0.055,-0.078, $
        -0.10, -0.121,-0.142,-0.164,-0.182,-0.201,-0.220,-0.238,-0.254,-0.273, $
        -0.291,-0.306,-0.321,-0.337,-0.351,-0.365,-0.377,-0.391,-0.416,-0.441, $
        -0.465,-0.490,-0.510,-0.529,-0.548,-0.566,-0.582,-0.597,-0.633,-0.663, $
        -0.718,-0.763,-0.840,-0.890,-0.960,-1.000]

  xtable = 10000.D+0 / refw
  temp=  size(wavelength,/DIMENSIONS)
  if temp[0] eq 0 then begin
    npts=1
    extl=double(0.0)
  endif else begin
    npts = temp[0]
    extl = dblarr(npts)
  endelse
  for pix = 0, npts-1 do begin
    if (wavelength[pix] lt 1000.0) then print, "redlaw_smc: Invalid wavelength"	
    ; Convert wavelength in angstroms to 1/microns
    x = 10000.D+0 / wavelength[pix]
    x = min([x, 10.0])
    
    ; Linearly interpolate extinction law in 1/lam
    val = lin_interp(extab, xtable,  x)
    ;deriv1 = spl_init(xtab, extab)
    ;val=spl_interp(xtab, extab, deriv1, x)

    extl[pix] = val
  endfor
  return, extl
end
