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

(declare-sort var374 0)
(declare-sort var2239 0)
(declare-sort var1144 0)
(declare-sort var929 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2239_getRuntime/1249267505 () var2239)
(declare-fun freeMemory/1964097530 (var2239) Int)
(declare-fun totalMemory/-606330162 (var2239) Int)
(declare-fun maxMemory/1135739438 (var2239) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1144-init () var1144)
(declare-fun <init>/294323258 (var1144 var929 String) void)
(declare-const null-var374 var374)
(declare-const var929-WARN var929)
(declare-const var3424 var374) ; Statement: r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker 
(assert (not (= var3424 null-var374)))
(define-const var1491 var2239 var2239_getRuntime/1249267505) ; Statement: r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert true)
(define-const var1697 Int (freeMemory/1964097530 var1491)) ; Statement: l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>() 
(assert true)
(define-const var243 Int (totalMemory/-606330162 var1491)) ; Statement: l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>() 
(assert true)
(define-const var583 Int (maxMemory/1135739438 var1491)) ; Statement: l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>() 
(define-const var2878 Int (- var243 var1697)) ; Statement: $l3 = l1 - l0 
(define-const var2271 Int (- var583 var2878)) ; Statement: $l4 = l2 - $l3 
(define-const var1807 Int (ite (> var2271 2097152) 1 (ite (< var2271 2097152) -1 0))) ; Statement: $b5 = $l4 cmp 2097152L 
(define-const var2664 Int (cast-from-Int-to-Int var1807)) ; Statement: $i17 = (int) $b5 
 ; Statement: if $i17 <= 0 goto $z0 = 0 
(assert (<= var2664 0)) ; Cond: $i17 <= 0 
(define-const var2330 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
(define-const var2875 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2875)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2875!1 String)
(assert (= var2875!1 ""))
(assert true)
(define-const var2819 String (append/672562846 var2875!1 "max:")) ; Statement: $r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:") 
(declare-const var2875!2 String)
(assert (= var2875!2 (str.++ var2875!1 "max:")))
(define-const var312 Int (div var583 1024)) ; Statement: $l6 = l2 / 1024L 
(define-const var994 Int (div var312 1024)) ; Statement: $l7 = $l6 / 1024L 
(assert true)
(define-const var966 String (append/-901862667 var2819 var994)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var2819!1 String)
(assert (str.prefixof var2819 var2819!1))
(assert true)
(define-const var1010 String (append/672562846 var966 "M,total:")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:") 
(declare-const var966!1 String)
(assert (= var966!1 (str.++ var966 "M,total:")))
(define-const var163 Int (div var243 1024)) ; Statement: $l8 = l1 / 1024L 
(define-const var2461 Int (div var163 1024)) ; Statement: $l9 = $l8 / 1024L 
(assert true)
(define-const var1102 String (append/-901862667 var1010 var2461)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9) 
(declare-const var1010!1 String)
(assert (str.prefixof var1010 var1010!1))
(assert true)
(define-const var2281 String (append/672562846 var1102 "M,used:")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:") 
(declare-const var1102!1 String)
(assert (= var1102!1 (str.++ var1102 "M,used:")))
(define-const var3180 Int (div var243 1024)) ; Statement: $l10 = l1 / 1024L 
(define-const var1484 Int (div var3180 1024)) ; Statement: $l13 = $l10 / 1024L 
(define-const var405 Int (div var1697 1024)) ; Statement: $l11 = l0 / 1024L 
(define-const var3452 Int (div var405 1024)) ; Statement: $l12 = $l11 / 1024L 
(define-const var2879 Int (- var1484 var3452)) ; Statement: $l14 = $l13 - $l12 
(assert true)
(define-const var2234 String (append/-901862667 var2281 var2879)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14) 
(declare-const var2281!1 String)
(assert (str.prefixof var2281 var2281!1))
(assert true)
(define-const var1253 String (append/672562846 var2234 "M,free:")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:") 
(declare-const var2234!1 String)
(assert (= var2234!1 (str.++ var2234 "M,free:")))
(define-const var2823 Int (div var1697 1024)) ; Statement: $l15 = l0 / 1024L 
(define-const var1817 Int (div var2823 1024)) ; Statement: $l16 = $l15 / 1024L 
(assert true)
(define-const var1851 String (append/-901862667 var1253 var1817)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16) 
(declare-const var1253!1 String)
(assert (str.prefixof var1253 var1253!1))
(assert true)
(define-const var1107 String (append/672562846 var1851 "M")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M") 
(declare-const var1851!1 String)
(assert (= var1851!1 (str.++ var1851 "M")))
(assert true)
(define-const var3619 String (toString/-2075883882 var1107)) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var581 var1144 var1144-init) ; Statement: $r16 = new org.apache.dubbo.common.status.Status 
 ; Statement: if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN> 
(assert (= (ite var2330 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1613 var929 var929-WARN) ; Statement: $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN> 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/294323258 var581 var1613 var3619)) ; Statement: specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12) 

(declare-const var581!1 var1144)
(declare-const var1613!1 var929)
(declare-const var3619!1 String)
 ; Statement: return $r16 
(check-sat)
; {var2239_getRuntime/1249267505=([], java.lang.Runtime), freeMemory/1964097530=([java.lang.Runtime], long), totalMemory/-606330162=([java.lang.Runtime], long), maxMemory/1135739438=([java.lang.Runtime], long), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1144-init=([], org.apache.dubbo.common.status.Status), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var374=org.apache.dubbo.common.status.support.MemoryStatusChecker, var3424=r13, var2239=java.lang.Runtime, var1491=r0, var1697=l0, var243=l1, var583=l2, var2878=$l3, var2271=$l4, var1807=$b5, var2664=$i17, var2330=$z0, var2875=$r15, var2819=$r2, var312=$l6, var994=$l7, var966=$r3, var1010=$r4, var163=$l8, var2461=$l9, var1102=$r5, var2281=$r6, var3180=$l10, var1484=$l13, var405=$l11, var3452=$l12, var2879=$l14, var2234=$r7, var1253=$r8, var2823=$l15, var1817=$l16, var1851=$r9, var1107=$r10, var3619=$r12, var1144=org.apache.dubbo.common.status.Status, var581=$r16, var929=org.apache.dubbo.common.status.Status$Level, var1613=$r14}
; {org.apache.dubbo.common.status.support.MemoryStatusChecker=var374, r13=var3424, java.lang.Runtime=var2239, r0=var1491, l0=var1697, l1=var243, l2=var583, $l3=var2878, $l4=var2271, $b5=var1807, $i17=var2664, $z0=var2330, $r15=var2875, $r2=var2819, $l6=var312, $l7=var994, $r3=var966, $r4=var1010, $l8=var163, $l9=var2461, $r5=var1102, $r6=var2281, $l10=var3180, $l13=var1484, $l11=var405, $l12=var3452, $l14=var2879, $r7=var2234, $r8=var1253, $l15=var2823, $l16=var1817, $r9=var1851, $r10=var1107, $r12=var3619, org.apache.dubbo.common.status.Status=var1144, $r16=var581, org.apache.dubbo.common.status.Status$Level=var929, $r14=var1613}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker;	r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>();	l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>();	l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>();	$l3 = l1 - l0;	$l4 = l2 - $l3;	$b5 = $l4 cmp 2097152L;	$i17 = (int) $b5;	if $i17 <= 0 goto $z0 = 0;	$z0 = 0;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:");	$l6 = l2 / 1024L;	$l7 = $l6 / 1024L;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:");	$l8 = l1 / 1024L;	$l9 = $l8 / 1024L;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:");	$l10 = l1 / 1024L;	$l13 = $l10 / 1024L;	$l11 = l0 / 1024L;	$l12 = $l11 / 1024L;	$l14 = $l13 - $l12;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:");	$l15 = l0 / 1024L;	$l16 = $l15 / 1024L;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M");	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = new org.apache.dubbo.common.status.Status;	if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN>;	$r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN>;	specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12);	return $r16
;block_num 5