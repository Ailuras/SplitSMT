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

(declare-sort var2488 0)
(declare-sort var2930 0)
(declare-sort var953 0)
(declare-sort var3295 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2930_getRuntime/1249267505 () var2930)
(declare-fun freeMemory/1964097530 (var2930) Int)
(declare-fun totalMemory/-606330162 (var2930) Int)
(declare-fun maxMemory/1135739438 (var2930) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var953-init () var953)
(declare-fun <init>/294323258 (var953 var3295 String) void)
(declare-const null-var2488 var2488)
(declare-const var3295-OK var3295)
(declare-const var1692 var2488) ; Statement: r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker 
(assert (not (= var1692 null-var2488)))
(define-const var190 var2930 var2930_getRuntime/1249267505) ; Statement: r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert true)
(define-const var2590 Int (freeMemory/1964097530 var190)) ; Statement: l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>() 
(assert true)
(define-const var2844 Int (totalMemory/-606330162 var190)) ; Statement: l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>() 
(assert true)
(define-const var2007 Int (maxMemory/1135739438 var190)) ; Statement: l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>() 
(define-const var1346 Int (- var2844 var2590)) ; Statement: $l3 = l1 - l0 
(define-const var1124 Int (- var2007 var1346)) ; Statement: $l4 = l2 - $l3 
(define-const var1580 Int (ite (> var1124 2097152) 1 (ite (< var1124 2097152) -1 0))) ; Statement: $b5 = $l4 cmp 2097152L 
(define-const var2222 Int (cast-from-Int-to-Int var1580)) ; Statement: $i17 = (int) $b5 
 ; Statement: if $i17 <= 0 goto $z0 = 0 
(assert (<= var2222 0)) ; Cond: $i17 <= 0 
(define-const var3795 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
(define-const var2886 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2886)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2886!1 String)
(assert (= var2886!1 ""))
(assert true)
(define-const var555 String (append/672562846 var2886!1 "max:")) ; Statement: $r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:") 
(declare-const var2886!2 String)
(assert (= var2886!2 (str.++ var2886!1 "max:")))
(define-const var2151 Int (div var2007 1024)) ; Statement: $l6 = l2 / 1024L 
(define-const var3726 Int (div var2151 1024)) ; Statement: $l7 = $l6 / 1024L 
(assert true)
(define-const var2377 String (append/-901862667 var555 var3726)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var555!1 String)
(assert (str.prefixof var555 var555!1))
(assert true)
(define-const var554 String (append/672562846 var2377 "M,total:")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:") 
(declare-const var2377!1 String)
(assert (= var2377!1 (str.++ var2377 "M,total:")))
(define-const var2349 Int (div var2844 1024)) ; Statement: $l8 = l1 / 1024L 
(define-const var2372 Int (div var2349 1024)) ; Statement: $l9 = $l8 / 1024L 
(assert true)
(define-const var3730 String (append/-901862667 var554 var2372)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9) 
(declare-const var554!1 String)
(assert (str.prefixof var554 var554!1))
(assert true)
(define-const var695 String (append/672562846 var3730 "M,used:")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:") 
(declare-const var3730!1 String)
(assert (= var3730!1 (str.++ var3730 "M,used:")))
(define-const var1803 Int (div var2844 1024)) ; Statement: $l10 = l1 / 1024L 
(define-const var688 Int (div var1803 1024)) ; Statement: $l13 = $l10 / 1024L 
(define-const var935 Int (div var2590 1024)) ; Statement: $l11 = l0 / 1024L 
(define-const var1657 Int (div var935 1024)) ; Statement: $l12 = $l11 / 1024L 
(define-const var1669 Int (- var688 var1657)) ; Statement: $l14 = $l13 - $l12 
(assert true)
(define-const var1715 String (append/-901862667 var695 var1669)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14) 
(declare-const var695!1 String)
(assert (str.prefixof var695 var695!1))
(assert true)
(define-const var3089 String (append/672562846 var1715 "M,free:")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:") 
(declare-const var1715!1 String)
(assert (= var1715!1 (str.++ var1715 "M,free:")))
(define-const var2119 Int (div var2590 1024)) ; Statement: $l15 = l0 / 1024L 
(define-const var2063 Int (div var2119 1024)) ; Statement: $l16 = $l15 / 1024L 
(assert true)
(define-const var1934 String (append/-901862667 var3089 var2063)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16) 
(declare-const var3089!1 String)
(assert (str.prefixof var3089 var3089!1))
(assert true)
(define-const var3000 String (append/672562846 var1934 "M")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M") 
(declare-const var1934!1 String)
(assert (= var1934!1 (str.++ var1934 "M")))
(assert true)
(define-const var3156 String (toString/-2075883882 var3000)) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var45 var953 var953-init) ; Statement: $r16 = new org.apache.dubbo.common.status.Status 
 ; Statement: if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN> 
(assert (not (= (ite var3795 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var610 var3295 var3295-OK) ; Statement: $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK> 
 ; Statement: goto [?= specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12)] 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/294323258 var45 var610 var3156)) ; Statement: specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12) 

(declare-const var45!1 var953)
(declare-const var610!1 var3295)
(declare-const var3156!1 String)
 ; Statement: return $r16 
(check-sat)
; {var2930_getRuntime/1249267505=([], java.lang.Runtime), freeMemory/1964097530=([java.lang.Runtime], long), totalMemory/-606330162=([java.lang.Runtime], long), maxMemory/1135739438=([java.lang.Runtime], long), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var953-init=([], org.apache.dubbo.common.status.Status), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var2488=org.apache.dubbo.common.status.support.MemoryStatusChecker, var1692=r13, var2930=java.lang.Runtime, var190=r0, var2590=l0, var2844=l1, var2007=l2, var1346=$l3, var1124=$l4, var1580=$b5, var2222=$i17, var3795=$z0, var2886=$r15, var555=$r2, var2151=$l6, var3726=$l7, var2377=$r3, var554=$r4, var2349=$l8, var2372=$l9, var3730=$r5, var695=$r6, var1803=$l10, var688=$l13, var935=$l11, var1657=$l12, var1669=$l14, var1715=$r7, var3089=$r8, var2119=$l15, var2063=$l16, var1934=$r9, var3000=$r10, var3156=$r12, var953=org.apache.dubbo.common.status.Status, var45=$r16, var3295=org.apache.dubbo.common.status.Status$Level, var610=$r14}
; {org.apache.dubbo.common.status.support.MemoryStatusChecker=var2488, r13=var1692, java.lang.Runtime=var2930, r0=var190, l0=var2590, l1=var2844, l2=var2007, $l3=var1346, $l4=var1124, $b5=var1580, $i17=var2222, $z0=var3795, $r15=var2886, $r2=var555, $l6=var2151, $l7=var3726, $r3=var2377, $r4=var554, $l8=var2349, $l9=var2372, $r5=var3730, $r6=var695, $l10=var1803, $l13=var688, $l11=var935, $l12=var1657, $l14=var1669, $r7=var1715, $r8=var3089, $l15=var2119, $l16=var2063, $r9=var1934, $r10=var3000, $r12=var3156, org.apache.dubbo.common.status.Status=var953, $r16=var45, org.apache.dubbo.common.status.Status$Level=var3295, $r14=var610}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker;	r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>();	l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>();	l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>();	$l3 = l1 - l0;	$l4 = l2 - $l3;	$b5 = $l4 cmp 2097152L;	$i17 = (int) $b5;	if $i17 <= 0 goto $z0 = 0;	$z0 = 0;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:");	$l6 = l2 / 1024L;	$l7 = $l6 / 1024L;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:");	$l8 = l1 / 1024L;	$l9 = $l8 / 1024L;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:");	$l10 = l1 / 1024L;	$l13 = $l10 / 1024L;	$l11 = l0 / 1024L;	$l12 = $l11 / 1024L;	$l14 = $l13 - $l12;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:");	$l15 = l0 / 1024L;	$l16 = $l15 / 1024L;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M");	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = new org.apache.dubbo.common.status.Status;	if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN>;	$r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK>;	goto [?= specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12)];	specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12);	return $r16
;block_num 5