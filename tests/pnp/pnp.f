c-----------------------------------------------------------------------
c
c  USER SPECIFIED ROUTINES:
c
c     - boundary conditions
c     - initial conditions
c     - variable properties
c     - forcing function for fluid (f)
c     - forcing function for passive scalar (q)
c     - general purpose routine for checking errors etc.
c
c-----------------------------------------------------------------------
      subroutine userinc
c-----------------------------------------------------------------------
      include 'SIZE'
      include 'TOTAL'

      return
      end

c-----------------------------------------------------------------------
      subroutine userini(tt,mycn)
c-----------------------------------------------------------------------
      include 'SIZE'
      include 'TOTAL'
      include 'DRIFT'
      real xx
      real mycn(lx1*ly1*lz1*lelt,lcdim) ! cN
      
      do i = 1,npts
        mycn(i,1) = 0.0  ! Na
        mycn(i,2) = 0.0  ! Cl
        mycn(i,3) = 3.0  ! K
        mycn(i,4) = 3.0  ! OH
      enddo

      return
      end

c-----------------------------------------------------------------------
      subroutine usersol(tt,myscn1,myscn2,myscn3,myscn4,myscn5,myscn6)
c-----------------------------------------------------------------------
      implicit none
      include 'SIZE'
      include 'TOTAL'
      include 'DRIFT'

      real tt
      real myscn1(lx1*ly1*lz1*lelt) !potent
      real myscn2(lx1*ly1*lz1*lelt,lcdim) !cN
      real myscn3(lx1*ly1*lz1*lelt)
      real myscn4(lx1*ly1*lz1*lelt)
      real myscn5(lx1*ly1*lz1*lelt)
      real myscn6(lx1*ly1*lz1*lelt)

      return
      end

c-----------------------------------------------------------------------
      subroutine usersrc(tt,rhs_phi,rhs_cn,dummy1,dummy2,dummy3,dummy4)     
c-----------------------------------------------------------------------
      implicit none
      include 'SIZE'
      include 'TOTAL'
      include 'DRIFT'
      include 'POISSON'
      include 'BCS'

      integer i,j,i0,ic 
      real    tt, xx
      real    rhs_cn(lpts1,lcdim)
      real    rhs_phi(1), dummy1(1),dummy2(1)
      real    dummy3(1),dummy4(1)
      call rzero(rhs_cN(1,1),npts)
      call rzero(rhs_cN(1,2),npts)
      call rzero(rhs_cN(1,3),npts)
      call rzero(rhs_cN(1,4),npts)

      if (ncemface_pec(2).ge.1)  then ! second field Na

         do i=1,ncemface_pec(2)
            j = cemface_pec(i,2)
            i0 = cemface(j)
            cn(i0,1) = 1.0
         enddo
      endif

      if (ncemface_pec(3).ge.1)  then ! third field Cl

         do i=1,ncemface_pec(3)
            j = cemface_pec(i,3) 
            i0 = cemface(j)      
            cN(i0,2) = 1.0
         enddo

      endif

      if (ncemface_pec(4).ge.1)  then ! third field K

         do i=1,ncemface_pec(4)
            j = cemface_pec(i,4)
            i0 = cemface(j)
            cn(i0,3) = 0.0
         enddo
      endif

      if (ncemface_pec(5).ge.1)  then ! fourth field OH

         do i=1,ncemface_pec(5)
            j = cemface_pec(i,5)
            i0 = cemface(j)
            cN(i0,4) = 0.0
         enddo

      endif

      return
      end

c-----------------------------------------------------------------------
      subroutine uservp (ix,iy,iz,iel)
c---------------------------------------------------------------------
      include 'SIZE'
      include 'TOTAL'
      include 'DRIFT'
      include 'POISSON'

      parameter(lt=lx1*ly1*lz1*lelt)
      common /myfields/ perm(lt),diff(lt),distp(lt),psrc(lt)
     $                , phip(lt),phix(lt),phiy(lt),phiz(lt)

      integer i,j,k,l,ie,ieg
      
      ! z_k
      zvalence(1) =  1.0 ! Na
      zvalence(2) = -1.0 ! Cl
      zvalence(3) =  1.0 ! K 
      zvalence(4) = -1.0 ! OH
      
      ! mu_n = u_n*F  (Faraday const: 96500)
      ! diff_n = D_n
      do i= 1,npts 
         mu_n    (i,1) =  5.1917E-10
         mu_n    (i,2) =  7.913E-10 
         mu_n    (i,3) =  7.6235E-10
         mu_n    (i,4) =  2.0651E-9 
         diff_n  (i,1) =  1.33E-11
         diff_n  (i,2) =  2.03E-11 
         diff_n  (i,3) =  1.96E-11
         diff_n  (i,4) =  5.30E-11
      enddo

      return
      end

c-----------------------------------------------------------------------
      subroutine usrdat
      include 'SIZE'
      include 'TOTAL'

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat2
      include 'SIZE'
      include 'TOTAL'

      return
      end

c-----------------------------------------------------------------------
      subroutine userchk
c-----------------------------------------------------------------------
      include 'SIZE'
      include 'TOTAL'
      include 'DRIFT'
      include 'POISSON'
      include 'RTIMER'

      real l2(6),linf(6)
      
      call userprint(istep,time,dt,l2,linf,cpu_t,cpu_p_t)

      return
      end

c-----------------------------------------------------------------------
      subroutine userprint(istep,tt,dt,l2,linf,t1,t2)
c-----------------------------------------------------------------------
      implicit none
      include 'SIZE'

      integer istep
      real tt,dt,t1,t2
      real l2(6),linf(6)

      integer k

      if (nid.eq.0) then
         write(6,101) istep,nelt,nx1-1,npts,tt,dt
      endif

 101  format(/,i10,i6,i4,i9,1p2e10.3,'=======')

      return
      end
c-----------------------------------------------------------------------

c automatically added by makenek
      subroutine userf(ix,iy,iz,eg)

      return
      end

c automatically added by makenek
      subroutine userq(ix,iy,iz,eg)

      return
      end

c automatically added by makenek
      subroutine useric(ix,iy,iz,eg) 

      return
      end

c automatically added by makenek
      subroutine userbc(ix,iy,iz,iside,eg)

      return
      end

c automatically added by makenek
      subroutine usrdat0() 

      return
      end

c automatically added by makenek
      subroutine usrdat3 

      return
      end

c automatically added by makenek
      subroutine usrsetvert(glo_num,nel,nx,ny,nz) ! to modify glo_num
      integer*8 glo_num(1)

      return
      end