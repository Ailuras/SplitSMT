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

(declare-sort var400 0)
(declare-sort var3267 0)
(declare-sort var1 0)
(declare-sort var2814 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3267_getRuntime/1249267505 () var3267)
(declare-fun freeMemory/1964097530 (var3267) Int)
(declare-fun totalMemory/-606330162 (var3267) Int)
(declare-fun maxMemory/1135739438 (var3267) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1-init () var1)
(declare-fun <init>/294323258 (var1 var2814 String) void)
(declare-const null-var400 var400)
(declare-const var2814-OK var2814)
(declare-const var9 var400) ; Statement: r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker 
(assert (not (= var9 null-var400)))
(define-const var2967 var3267 var3267_getRuntime/1249267505) ; Statement: r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert true)
(define-const var3258 Int (freeMemory/1964097530 var2967)) ; Statement: l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>() 
(assert true)
(define-const var2217 Int (totalMemory/-606330162 var2967)) ; Statement: l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>() 
(assert true)
(define-const var126 Int (maxMemory/1135739438 var2967)) ; Statement: l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>() 
(define-const var2581 Int (- var2217 var3258)) ; Statement: $l3 = l1 - l0 
(define-const var504 Int (- var126 var2581)) ; Statement: $l4 = l2 - $l3 
(define-const var683 Int (ite (> var504 2097152) 1 (ite (< var504 2097152) -1 0))) ; Statement: $b5 = $l4 cmp 2097152L 
(define-const var174 Int (cast-from-Int-to-Int var683)) ; Statement: $i17 = (int) $b5 
 ; Statement: if $i17 <= 0 goto $z0 = 0 
(assert (not (<= var174 0))) ; Negate: Cond: $i17 <= 0  
(define-const var3583 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= $r15 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var1769 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1769)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1769!1 String)
(assert (= var1769!1 ""))
(assert true)
(define-const var3988 String (append/672562846 var1769!1 "max:")) ; Statement: $r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:") 
(declare-const var1769!2 String)
(assert (= var1769!2 (str.++ var1769!1 "max:")))
(define-const var2099 Int (div var126 1024)) ; Statement: $l6 = l2 / 1024L 
(define-const var1276 Int (div var2099 1024)) ; Statement: $l7 = $l6 / 1024L 
(assert true)
(define-const var1090 String (append/-901862667 var3988 var1276)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var3988!1 String)
(assert (str.prefixof var3988 var3988!1))
(assert true)
(define-const var2742 String (append/672562846 var1090 "M,total:")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:") 
(declare-const var1090!1 String)
(assert (= var1090!1 (str.++ var1090 "M,total:")))
(define-const var39 Int (div var2217 1024)) ; Statement: $l8 = l1 / 1024L 
(define-const var96 Int (div var39 1024)) ; Statement: $l9 = $l8 / 1024L 
(assert true)
(define-const var3977 String (append/-901862667 var2742 var96)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9) 
(declare-const var2742!1 String)
(assert (str.prefixof var2742 var2742!1))
(assert true)
(define-const var1204 String (append/672562846 var3977 "M,used:")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:") 
(declare-const var3977!1 String)
(assert (= var3977!1 (str.++ var3977 "M,used:")))
(define-const var1255 Int (div var2217 1024)) ; Statement: $l10 = l1 / 1024L 
(define-const var2817 Int (div var1255 1024)) ; Statement: $l13 = $l10 / 1024L 
(define-const var1587 Int (div var3258 1024)) ; Statement: $l11 = l0 / 1024L 
(define-const var3198 Int (div var1587 1024)) ; Statement: $l12 = $l11 / 1024L 
(define-const var1623 Int (- var2817 var3198)) ; Statement: $l14 = $l13 - $l12 
(assert true)
(define-const var470 String (append/-901862667 var1204 var1623)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14) 
(declare-const var1204!1 String)
(assert (str.prefixof var1204 var1204!1))
(assert true)
(define-const var2659 String (append/672562846 var470 "M,free:")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:") 
(declare-const var470!1 String)
(assert (= var470!1 (str.++ var470 "M,free:")))
(define-const var2559 Int (div var3258 1024)) ; Statement: $l15 = l0 / 1024L 
(define-const var2112 Int (div var2559 1024)) ; Statement: $l16 = $l15 / 1024L 
(assert true)
(define-const var1230 String (append/-901862667 var2659 var2112)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16) 
(declare-const var2659!1 String)
(assert (str.prefixof var2659 var2659!1))
(assert true)
(define-const var2424 String (append/672562846 var1230 "M")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M") 
(declare-const var1230!1 String)
(assert (= var1230!1 (str.++ var1230 "M")))
(assert true)
(define-const var796 String (toString/-2075883882 var2424)) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2779 var1 var1-init) ; Statement: $r16 = new org.apache.dubbo.common.status.Status 
 ; Statement: if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN> 
(assert (not (= (ite var3583 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3675 var2814 var2814-OK) ; Statement: $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK> 
 ; Statement: goto [?= specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12)] 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/294323258 var2779 var3675 var796)) ; Statement: specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12) 

(declare-const var2779!1 var1)
(declare-const var3675!1 var2814)
(declare-const var796!1 String)
 ; Statement: return $r16 
(check-sat)
; {var3267_getRuntime/1249267505=([], java.lang.Runtime), freeMemory/1964097530=([java.lang.Runtime], long), totalMemory/-606330162=([java.lang.Runtime], long), maxMemory/1135739438=([java.lang.Runtime], long), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1-init=([], org.apache.dubbo.common.status.Status), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var400=org.apache.dubbo.common.status.support.MemoryStatusChecker, var9=r13, var3267=java.lang.Runtime, var2967=r0, var3258=l0, var2217=l1, var126=l2, var2581=$l3, var504=$l4, var683=$b5, var174=$i17, var3583=$z0, var1769=$r15, var3988=$r2, var2099=$l6, var1276=$l7, var1090=$r3, var2742=$r4, var39=$l8, var96=$l9, var3977=$r5, var1204=$r6, var1255=$l10, var2817=$l13, var1587=$l11, var3198=$l12, var1623=$l14, var470=$r7, var2659=$r8, var2559=$l15, var2112=$l16, var1230=$r9, var2424=$r10, var796=$r12, var1=org.apache.dubbo.common.status.Status, var2779=$r16, var2814=org.apache.dubbo.common.status.Status$Level, var3675=$r14}
; {org.apache.dubbo.common.status.support.MemoryStatusChecker=var400, r13=var9, java.lang.Runtime=var3267, r0=var2967, l0=var3258, l1=var2217, l2=var126, $l3=var2581, $l4=var504, $b5=var683, $i17=var174, $z0=var3583, $r15=var1769, $r2=var3988, $l6=var2099, $l7=var1276, $r3=var1090, $r4=var2742, $l8=var39, $l9=var96, $r5=var3977, $r6=var1204, $l10=var1255, $l13=var2817, $l11=var1587, $l12=var3198, $l14=var1623, $r7=var470, $r8=var2659, $l15=var2559, $l16=var2112, $r9=var1230, $r10=var2424, $r12=var796, org.apache.dubbo.common.status.Status=var1, $r16=var2779, org.apache.dubbo.common.status.Status$Level=var2814, $r14=var3675}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r13 := @this: org.apache.dubbo.common.status.support.MemoryStatusChecker;	r0 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	l0 = virtualinvoke r0.<java.lang.Runtime: long freeMemory()>();	l1 = virtualinvoke r0.<java.lang.Runtime: long totalMemory()>();	l2 = virtualinvoke r0.<java.lang.Runtime: long maxMemory()>();	$l3 = l1 - l0;	$l4 = l2 - $l3;	$b5 = $l4 cmp 2097152L;	$i17 = (int) $b5;	if $i17 <= 0 goto $z0 = 0;	$z0 = 1;	goto [?= $r15 = new java.lang.StringBuilder];	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("max:");	$l6 = l2 / 1024L;	$l7 = $l6 / 1024L;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,total:");	$l8 = l1 / 1024L;	$l9 = $l8 / 1024L;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l9);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,used:");	$l10 = l1 / 1024L;	$l13 = $l10 / 1024L;	$l11 = l0 / 1024L;	$l12 = $l11 / 1024L;	$l14 = $l13 - $l12;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l14);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M,free:");	$l15 = l0 / 1024L;	$l16 = $l15 / 1024L;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l16);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("M");	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = new org.apache.dubbo.common.status.Status;	if $z0 == 0 goto $r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level WARN>;	$r14 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK>;	goto [?= specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12)];	specialinvoke $r16.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>($r14, $r12);	return $r16
;block_num 5