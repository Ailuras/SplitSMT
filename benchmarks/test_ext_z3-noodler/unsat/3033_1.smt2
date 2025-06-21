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

(declare-sort var2878 0)
(declare-sort var488 0)
(declare-sort var2787 0)
(declare-sort var2916 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var488_getRuntime/1249267505 () var488)
(declare-fun freeMemory/1964097530 (var488) Int)
(declare-fun totalMemory/-606330162 (var488) Int)
(declare-fun maxMemory/1135739438 (var488) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2787-init () var2787)
(declare-fun <init>/294323258 (var2787 var2916 String) void)
(declare-const null-var2878 var2878)
(declare-const var2916-WARN var2916)
(declare-const var3985 var2878) ; Statement: r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker 
(assert (not (= var3985 null-var2878)))
(define-const var2348 var488 var488_getRuntime/1249267505) ; Statement: r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert true)
(define-const var354 Int (freeMemory/1964097530 var2348)) ; Statement: l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>() 
(assert true)
(define-const var1135 Int (totalMemory/-606330162 var2348)) ; Statement: l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>() 
(assert true)
(define-const var369 Int (maxMemory/1135739438 var2348)) ; Statement: l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>() 
(define-const var2457 Int (- var1135 var354)) ; Statement: $l3 = l1 - l0 
(define-const var670 Int (- var369 var2457)) ; Statement: $l4 = l2 - $l3 
(define-const var1782 Int (ite (> var670 2097152) 1 (ite (< var670 2097152) -1 0))) ; Statement: $b5 = $l4 cmp 2097152L 
(define-const var285 Int (cast-from-Int-to-Int var1782)) ; Statement: $i17 = (int) $b5 
 ; Statement: if $i17 <= 0 goto $z0 = 0 
(assert (not (<= var285 0))) ; Negate: Cond: $i17 <= 0  
(define-const var2625 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= $r15 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var1319 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1319)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1319!1 String)
(assert (= var1319!1 ""))
(assert true)
(define-const var6 String (append/672562846 var1319!1 "max:")) ; Statement: $r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:") 
(declare-const var1319!2 String)
(assert (= var1319!2 (str.++ var1319!1 "max:")))
(define-const var2702 Int (div var369 1024)) ; Statement: $l6 = l2 / 1024L 
(define-const var1538 Int (div var2702 1024)) ; Statement: $l7 = $l6 / 1024L 
(assert true)
(define-const var2943 String (append/-901862667 var6 var1538)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var6!1 String)
(assert (str.prefixof var6 var6!1))
(assert true)
(define-const var1931 String (append/672562846 var2943 "M,total:")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:") 
(declare-const var2943!1 String)
(assert (= var2943!1 (str.++ var2943 "M,total:")))
(define-const var1970 Int (div var1135 1024)) ; Statement: $l8 = l1 / 1024L 
(define-const var1114 Int (div var1970 1024)) ; Statement: $l9 = $l8 / 1024L 
(assert true)
(define-const var1188 String (append/-901862667 var1931 var1114)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9) 
(declare-const var1931!1 String)
(assert (str.prefixof var1931 var1931!1))
(assert true)
(define-const var1339 String (append/672562846 var1188 "M,used:")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:") 
(declare-const var1188!1 String)
(assert (= var1188!1 (str.++ var1188 "M,used:")))
(define-const var734 Int (div var1135 1024)) ; Statement: $l10 = l1 / 1024L 
(define-const var3249 Int (div var734 1024)) ; Statement: $l13 = $l10 / 1024L 
(define-const var318 Int (div var354 1024)) ; Statement: $l11 = l0 / 1024L 
(define-const var3706 Int (div var318 1024)) ; Statement: $l12 = $l11 / 1024L 
(define-const var1580 Int (- var3249 var3706)) ; Statement: $l14 = $l13 - $l12 
(assert true)
(define-const var3785 String (append/-901862667 var1339 var1580)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14) 
(declare-const var1339!1 String)
(assert (str.prefixof var1339 var1339!1))
(assert true)
(define-const var3838 String (append/672562846 var3785 "M,free:")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:") 
(declare-const var3785!1 String)
(assert (= var3785!1 (str.++ var3785 "M,free:")))
(define-const var3483 Int (div var354 1024)) ; Statement: $l15 = l0 / 1024L 
(define-const var2628 Int (div var3483 1024)) ; Statement: $l16 = $l15 / 1024L 
(assert true)
(define-const var3987 String (append/-901862667 var3838 var2628)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16) 
(declare-const var3838!1 String)
(assert (str.prefixof var3838 var3838!1))
(assert true)
(define-const var3835 String (append/672562846 var3987 "M")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M") 
(declare-const var3987!1 String)
(assert (= var3987!1 (str.++ var3987 "M")))
(assert true)
(define-const var460 String (toString/-2075883882 var3835)) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2841 var2787 var2787-init) ; Statement: $r16 = new org.apache.dubbo.common.status.Status 
 ; Statement: if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN> 
(assert (= (ite var2625 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3496 var2916 var2916-WARN) ; Statement: $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN> 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/294323258 var2841 var3496 var460)) ; Statement: specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12) 

(declare-const var2841!1 var2787)
(declare-const var3496!1 var2916)
(declare-const var460!1 String)
 ; Statement: return $r16 
(check-sat)
; {var488_getRuntime/1249267505=([], java.lang.Runtime), freeMemory/1964097530=([java.lang.Runtime], long), totalMemory/-606330162=([java.lang.Runtime], long), maxMemory/1135739438=([java.lang.Runtime], long), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2787-init=([], org.apache.dubbo.common.status.Status), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var2878=org.apache.dubbo.common.status.support.MemoryStatusChecker, var3985=r13, var488=java.lang.Runtime, var2348=r0, var354=l0, var1135=l1, var369=l2, var2457=$l3, var670=$l4, var1782=$b5, var285=$i17, var2625=$z0, var1319=$r15, var6=$r2, var2702=$l6, var1538=$l7, var2943=$r3, var1931=$r4, var1970=$l8, var1114=$l9, var1188=$r5, var1339=$r6, var734=$l10, var3249=$l13, var318=$l11, var3706=$l12, var1580=$l14, var3785=$r7, var3838=$r8, var3483=$l15, var2628=$l16, var3987=$r9, var3835=$r10, var460=$r12, var2787=org.apache.dubbo.common.status.Status, var2841=$r16, var2916=org.apache.dubbo.common.status.Status$Level, var3496=$r14}
; {org.apache.dubbo.common.status.support.MemoryStatusChecker=var2878, r13=var3985, java.lang.Runtime=var488, r0=var2348, l0=var354, l1=var1135, l2=var369, $l3=var2457, $l4=var670, $b5=var1782, $i17=var285, $z0=var2625, $r15=var1319, $r2=var6, $l6=var2702, $l7=var1538, $r3=var2943, $r4=var1931, $l8=var1970, $l9=var1114, $r5=var1188, $r6=var1339, $l10=var734, $l13=var3249, $l11=var318, $l12=var3706, $l14=var1580, $r7=var3785, $r8=var3838, $l15=var3483, $l16=var2628, $r9=var3987, $r10=var3835, $r12=var460, org.apache.dubbo.common.status.Status=var2787, $r16=var2841, org.apache.dubbo.common.status.Status$Level=var2916, $r14=var3496}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker;	r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>();	l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>();	l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>();	$l3 = l1 - l0;	$l4 = l2 - $l3;	$b5 = $l4 cmp 2097152L;	$i17 = (int) $b5;	if $i17 <= 0 goto $z0 = 0;	$z0 = 1;	goto [?= $r15 = new java.lang.StringBuilder];	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:");	$l6 = l2 / 1024L;	$l7 = $l6 / 1024L;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:");	$l8 = l1 / 1024L;	$l9 = $l8 / 1024L;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:");	$l10 = l1 / 1024L;	$l13 = $l10 / 1024L;	$l11 = l0 / 1024L;	$l12 = $l11 / 1024L;	$l14 = $l13 - $l12;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:");	$l15 = l0 / 1024L;	$l16 = $l15 / 1024L;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M");	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = new org.apache.dubbo.common.status.Status;	if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN>;	$r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN>;	specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12);	return $r16
;block_num 5