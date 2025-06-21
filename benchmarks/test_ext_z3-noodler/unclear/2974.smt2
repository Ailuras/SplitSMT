(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3752 0)
(declare-sort var3678 0)
(declare-sort var3074 0)
(declare-sort var3964 0)
(declare-sort var616 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3074_getOperatingSystemBean/1539193888 () var3678)
(declare-fun var3678_getSystemLoadAverage/-502435534 (var3678) Float64)
(declare-fun var3678_getAvailableProcessors/-1532386750 (var3678) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/33611274 (String Float64) String)
(define-fun toString/-2075883882 ((s String)) String s)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var616-init () var616)
(declare-fun <init>/294323258 (var616 var3964 String) void)
(declare-const null-var3752 var3752)
(declare-const var3964-UNKNOWN var3964)
(declare-const var2712 var3752) ; Statement: r11 := @this: org.apache.dubbo.common.status.support.LoadStatusChecker 
(assert (not (= var2712 null-var3752)))
(define-const var3856 var3678 var3074_getOperatingSystemBean/1539193888) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>() 
(define-const var3607 Float64 (var3678_getSystemLoadAverage/-502435534 var3856)) ; Statement: d1 = interfaceinvoke $r0.<java.lang.management.OperatingSystemMXBean: double getSystemLoadAverage()>() 
(define-const var630 Int (ite (fp.gt var3607 ((_ to_fp 11 53) #xbff0000000000000)) 1 (ite (fp.lt var3607 ((_ to_fp 11 53) #xbff0000000000000)) -1 0))) ; Statement: $b0 = d1 cmpl -1.0 
 ; Statement: if $b0 != 0 goto $r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>() 
(assert (not (= var630 0))) ; Cond: $b0 != 0 
(define-const var264 var3678 var3074_getOperatingSystemBean/1539193888) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>() 
(define-const var1476 Int (var3678_getAvailableProcessors/-1532386750 var264)) ; Statement: $i3 = interfaceinvoke $r1.<java.lang.management.OperatingSystemMXBean: int getAvailableProcessors()>() 
(define-const var2605 Int (ite (fp.gt var3607 ((_ to_fp 11 53) #x0000000000000000)) 1 (ite (fp.lt var3607 ((_ to_fp 11 53) #x0000000000000000)) -1 0))) ; Statement: $b1 = d1 cmpg 0.0 
(define-const var228 Int (cast-from-Int-to-Int var2605)) ; Statement: $i5 = (int) $b1 
 ; Statement: if $i5 >= 0 goto $d0 = (double) $i3 
(assert (not (>= var228 0))) ; Negate: Cond: $i5 >= 0  
(define-const var3312 var3964 var3964-UNKNOWN) ; Statement: r12 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level UNKNOWN> 
 ; Statement: goto [?= $r15 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var3288 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3288)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3288!1 String)
(assert (= var3288!1 ""))
(define-const var295 Int (ite (fp.gt var3607 ((_ to_fp 11 53) #x0000000000000000)) 1 (ite (fp.lt var3607 ((_ to_fp 11 53) #x0000000000000000)) -1 0))) ; Statement: $b4 = d1 cmpg 0.0 
(define-const var1237 Int (cast-from-Int-to-Int var295)) ; Statement: $i7 = (int) $b4 
 ; Statement: if $i7 >= 0 goto $r16 = new java.lang.StringBuilder 
(assert (>= var1237 0)) ; Cond: $i7 >= 0 
(define-const var3708 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3708)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3708!1 String)
(assert (= var3708!1 ""))
(assert true)
(define-const var2426 String (append/672562846 var3708!1 "load:")) ; Statement: $r3 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("load:") 
(declare-const var3708!2 String)
(assert (= var3708!2 (str.++ var3708!1 "load:")))
(assert true)
(define-const var2016 String (append/33611274 var2426 var3607)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(double)>(d1) 
(declare-const var2426!1 String)
(assert (str.prefixof var2426 var2426!1))
(assert true)
(define-const var1615 String (append/672562846 var2016 ",")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var2016!1 String)
(assert (= var2016!1 (str.++ var2016 ",")))
(assert true)
(define-const var1050 String (toString/-2075883882 var1615)) ; Statement: $r14 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var2798 String (append/672562846 var3288!1 var1050)) ; Statement: $r6 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var3288!2 String)
(assert (= var3288!2 (str.++ var3288!1 var1050)))
(assert true)
(define-const var2295 String (append/672562846 var2798 "cpu:")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("cpu:") 
(declare-const var2798!1 String)
(assert (= var2798!1 (str.++ var2798 "cpu:")))
(assert true)
(define-const var1996 String (append/-1001720160 var2295 var1476)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i3) 
(declare-const var2295!1 String)
(assert (str.prefixof var2295 var2295!1))
(assert true)
(define-const var1114 String (toString/-2075883882 var1996)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2482 var616 var616-init) ; Statement: $r17 = new org.apache.dubbo.common.status.Status 
(assert true)
;(assert (<init>/294323258 var2482 var3312 var1114)) ; Statement: specialinvoke $r17.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r12, $r10) 

(declare-const var2482!1 var616)
(declare-const var3312!1 var3964)
(declare-const var1114!1 String)
 ; Statement: return $r17 
(check-sat)
; {var3074_getOperatingSystemBean/1539193888=([], java.lang.management.OperatingSystemMXBean), var3678_getSystemLoadAverage/-502435534=([java.lang.management.OperatingSystemMXBean], double), var3678_getAvailableProcessors/-1532386750=([java.lang.management.OperatingSystemMXBean], int), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/33611274=([java.lang.StringBuilder, double], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var616-init=([], org.apache.dubbo.common.status.Status), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var3752=org.apache.dubbo.common.status.support.LoadStatusChecker, var2712=r11, var3678=java.lang.management.OperatingSystemMXBean, var3074=org.apache.dubbo.common.system.OperatingSystemBeanManager, var3856=$r0, var3607=d1, var630=$b0, var264=$r1, var1476=$i3, var2605=$b1, var228=$i5, var3964=org.apache.dubbo.common.status.Status$Level, var3312=r12, var3288=$r15, var295=$b4, var1237=$i7, var3708=$r16, var2426=$r3, var2016=$r4, var1615=$r5, var1050=$r14, var2798=$r6, var2295=$r7, var1996=$r8, var1114=$r10, var616=org.apache.dubbo.common.status.Status, var2482=$r17}
; {org.apache.dubbo.common.status.support.LoadStatusChecker=var3752, r11=var2712, java.lang.management.OperatingSystemMXBean=var3678, org.apache.dubbo.common.system.OperatingSystemBeanManager=var3074, $r0=var3856, d1=var3607, $b0=var630, $r1=var264, $i3=var1476, $b1=var2605, $i5=var228, org.apache.dubbo.common.status.Status$Level=var3964, r12=var3312, $r15=var3288, $b4=var295, $i7=var1237, $r16=var3708, $r3=var2426, $r4=var2016, $r5=var1615, $r14=var1050, $r6=var2798, $r7=var2295, $r8=var1996, $r10=var1114, org.apache.dubbo.common.status.Status=var616, $r17=var2482}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(double)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(double)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1}
;stmts r11 := @this: org.apache.dubbo.common.status.support.LoadStatusChecker;	$r0 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>();	d1 = interfaceinvoke $r0.<java.lang.management.OperatingSystemMXBean: double getSystemLoadAverage()>();	$b0 = d1 cmpl -1.0;	if $b0 != 0 goto $r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>();	$r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>();	$i3 = interfaceinvoke $r1.<java.lang.management.OperatingSystemMXBean: int getAvailableProcessors()>();	$b1 = d1 cmpg 0.0;	$i5 = (int) $b1;	if $i5 >= 0 goto $d0 = (double) $i3;	r12 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level UNKNOWN>;	goto [?= $r15 = new java.lang.StringBuilder];	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$b4 = d1 cmpg 0.0;	$i7 = (int) $b4;	if $i7 >= 0 goto $r16 = new java.lang.StringBuilder;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("load:");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(double)>(d1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$r14 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("cpu:");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i3);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = new org.apache.dubbo.common.status.Status;	specialinvoke $r17.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r12, $r10);	return $r17
;block_num 6