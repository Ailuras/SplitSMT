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

(declare-sort var2217 0)
(declare-sort var29 0)
(declare-sort var1795 0)
(declare-sort var2777 0)
(declare-sort var2337 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1795_getOperatingSystemBean/1539193888 () var29)
(declare-fun var29_getSystemLoadAverage/-502435534 (var29) Float64)
(declare-fun var29_getAvailableProcessors/-1532386750 (var29) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2337-init () var2337)
(declare-fun <init>/294323258 (var2337 var2777 String) void)
(declare-const null-var2217 var2217)
(declare-const var2777-UNKNOWN var2777)
(declare-const var2864 var2217) ; Statement: r11 := @this: org.apache.dubbo.common.status.support.LoadStatusChecker 
(assert (not (= var2864 null-var2217)))
(define-const var1592 var29 var1795_getOperatingSystemBean/1539193888) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>() 
(define-const var1923 Float64 (var29_getSystemLoadAverage/-502435534 var1592)) ; Statement: d1 = interfaceinvoke $r0.<java.lang.management.OperatingSystemMXBean: double getSystemLoadAverage()>() 
(define-const var3852 Int (ite (fp.gt var1923 ((_ to_fp 11 53) #xbff0000000000000)) 1 (ite (fp.lt var1923 ((_ to_fp 11 53) #xbff0000000000000)) -1 0))) ; Statement: $b0 = d1 cmpl -1.0 
 ; Statement: if $b0 != 0 goto $r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>() 
(assert (not (= var3852 0))) ; Cond: $b0 != 0 
(define-const var2343 var29 var1795_getOperatingSystemBean/1539193888) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>() 
(define-const var3779 Int (var29_getAvailableProcessors/-1532386750 var2343)) ; Statement: $i3 = interfaceinvoke $r1.<java.lang.management.OperatingSystemMXBean: int getAvailableProcessors()>() 
(define-const var609 Int (ite (fp.gt var1923 ((_ to_fp 11 53) #x0000000000000000)) 1 (ite (fp.lt var1923 ((_ to_fp 11 53) #x0000000000000000)) -1 0))) ; Statement: $b1 = d1 cmpg 0.0 
(define-const var1026 Int (cast-from-Int-to-Int var609)) ; Statement: $i5 = (int) $b1 
 ; Statement: if $i5 >= 0 goto $d0 = (double) $i3 
(assert (not (>= var1026 0))) ; Negate: Cond: $i5 >= 0  
(define-const var2667 var2777 var2777-UNKNOWN) ; Statement: r12 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level UNKNOWN> 
 ; Statement: goto [?= $r15 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var2195 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2195)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2195!1 String)
(assert (= var2195!1 ""))
(define-const var559 Int (ite (fp.gt var1923 ((_ to_fp 11 53) #x0000000000000000)) 1 (ite (fp.lt var1923 ((_ to_fp 11 53) #x0000000000000000)) -1 0))) ; Statement: $b4 = d1 cmpg 0.0 
(define-const var1148 Int (cast-from-Int-to-Int var559)) ; Statement: $i7 = (int) $b4 
 ; Statement: if $i7 >= 0 goto $r16 = new java.lang.StringBuilder 
(assert (not (>= var1148 0))) ; Negate: Cond: $i7 >= 0  
(define-const var671 String "") ; Statement: $r14 = "" 
 ; Statement: goto [?= $r6 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14)] 
(assert true) ; Non Conditional
(assert true)
(define-const var723 String (append/672562846 var2195!1 var671)) ; Statement: $r6 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var2195!2 String)
(assert (= var2195!2 (str.++ var2195!1 var671)))
(assert true)
(define-const var2625 String (append/672562846 var723 "cpu:")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("cpu:") 
(declare-const var723!1 String)
(assert (= var723!1 (str.++ var723 "cpu:")))
(assert true)
(define-const var503 String (append/-1001720160 var2625 var3779)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i3) 
(declare-const var2625!1 String)
(assert (str.prefixof var2625 var2625!1))
(assert true)
(define-const var1988 String (toString/-2075883882 var503)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1880 var2337 var2337-init) ; Statement: $r17 = new org.apache.dubbo.common.status.Status 
(assert true)
;(assert (<init>/294323258 var1880 var2667 var1988)) ; Statement: specialinvoke $r17.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r12, $r10) 

(declare-const var1880!1 var2337)
(declare-const var2667!1 var2777)
(declare-const var1988!1 String)
 ; Statement: return $r17 
(check-sat)
; {var1795_getOperatingSystemBean/1539193888=([], java.lang.management.OperatingSystemMXBean), var29_getSystemLoadAverage/-502435534=([java.lang.management.OperatingSystemMXBean], double), var29_getAvailableProcessors/-1532386750=([java.lang.management.OperatingSystemMXBean], int), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2337-init=([], org.apache.dubbo.common.status.Status), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var2217=org.apache.dubbo.common.status.support.LoadStatusChecker, var2864=r11, var29=java.lang.management.OperatingSystemMXBean, var1795=org.apache.dubbo.common.system.OperatingSystemBeanManager, var1592=$r0, var1923=d1, var3852=$b0, var2343=$r1, var3779=$i3, var609=$b1, var1026=$i5, var2777=org.apache.dubbo.common.status.Status$Level, var2667=r12, var2195=$r15, var559=$b4, var1148=$i7, var671=$r14, var723=$r6, var2625=$r7, var503=$r8, var1988=$r10, var2337=org.apache.dubbo.common.status.Status, var1880=$r17}
; {org.apache.dubbo.common.status.support.LoadStatusChecker=var2217, r11=var2864, java.lang.management.OperatingSystemMXBean=var29, org.apache.dubbo.common.system.OperatingSystemBeanManager=var1795, $r0=var1592, d1=var1923, $b0=var3852, $r1=var2343, $i3=var3779, $b1=var609, $i5=var1026, org.apache.dubbo.common.status.Status$Level=var2777, r12=var2667, $r15=var2195, $b4=var559, $i7=var1148, $r14=var671, $r6=var723, $r7=var2625, $r8=var503, $r10=var1988, org.apache.dubbo.common.status.Status=var2337, $r17=var1880}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @this: org.apache.dubbo.common.status.support.LoadStatusChecker;	$r0 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>();	d1 = interfaceinvoke $r0.<java.lang.management.OperatingSystemMXBean: double getSystemLoadAverage()>();	$b0 = d1 cmpl -1.0;	if $b0 != 0 goto $r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>();	$r1 = staticinvoke <org.apache.dubbo.common.system.OperatingSystemBeanManager: java.lang.management.OperatingSystemMXBean getOperatingSystemBean()>();	$i3 = interfaceinvoke $r1.<java.lang.management.OperatingSystemMXBean: int getAvailableProcessors()>();	$b1 = d1 cmpg 0.0;	$i5 = (int) $b1;	if $i5 >= 0 goto $d0 = (double) $i3;	r12 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level UNKNOWN>;	goto [?= $r15 = new java.lang.StringBuilder];	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$b4 = d1 cmpg 0.0;	$i7 = (int) $b4;	if $i7 >= 0 goto $r16 = new java.lang.StringBuilder;	$r14 = "";	goto [?= $r6 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14)];	$r6 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("cpu:");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i3);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = new org.apache.dubbo.common.status.Status;	specialinvoke $r17.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r12, $r10);	return $r17
;block_num 6