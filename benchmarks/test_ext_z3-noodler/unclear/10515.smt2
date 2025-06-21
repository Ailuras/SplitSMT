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

(declare-sort var3311 0)
(declare-sort var3189 0)
(declare-sort var2571 0)
(declare-sort var8 0)
(declare-sort var1399 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3189) void)
(declare-fun cast-from-var3311-to-var3189 (var3311) var3189)
(declare-fun var2571-init () var2571)
(declare-fun <init>/-377021476 (var2571) void)
(declare-fun updateLock/-729328706 (var3311) var2571)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var8_assertTrue/528204808 (Bool String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun paneCount/-729328706 (var3311) Int)
(declare-fun intervalInMs/-729328706 (var3311) Int)
(declare-fun paneIntervalInMs/-729328706 (var3311) Int)
(declare-fun var1399-init () var1399)
(declare-fun <init>/-134673613 (var1399 Int) void)
(declare-fun referenceArray/-729328706 (var3311) var1399)
(declare-const null-var3311 var3311)
(declare-const null-Int Int)
(declare-const var848 var3311) ; Statement: r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow 
(assert (not (= var848 null-var3311)))
(declare-const var747 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var747 null-Int)))
(declare-const var3067 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var3067 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3311-to-var3189 var848))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var848!1 var3311)
(define-const var1595 var2571 var2571-init) ; Statement: $r7 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var1595)) ; Statement: specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var1595!1 var2571)
(declare-const var848!2 var3311)
(assert (not (= var848!2 null-var3311)))
(assert (= (updateLock/-729328706 var848!2) var1595!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7 
 ; Statement: if i0 <= 0 goto $z0 = 0 
(assert (<= var747 0)) ; Cond: i0 <= 0 
(define-const var3798 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
(define-const var883 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var883)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var883!1 String)
(assert (= var883!1 ""))
(assert true)
(define-const var2329 String (append/672562846 var883!1 "pane count is invalid: ")) ; Statement: $r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ") 
(declare-const var883!2 String)
(assert (= var883!2 (str.++ var883!1 "pane count is invalid: ")))
(assert true)
(define-const var1402 String (append/-1001720160 var2329 var747)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2329!1 String)
(assert (str.prefixof var2329 var2329!1))
(assert true)
(define-const var1163 String (toString/-2075883882 var1402)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var8_assertTrue/528204808 var3798 var1163)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5) 

(declare-const var3798!1 Bool)
(declare-const var1163!1 String)
(define-const var1710 Int (ite (> var3067 0) 1 (ite (< var3067 0) -1 0))) ; Statement: $b2 = l1 cmp 0L 
(define-const var2467 Int (cast-from-Int-to-Int var1710)) ; Statement: $i8 = (int) $b2 
 ; Statement: if $i8 <= 0 goto $z1 = 0 
(assert (not (<= var2467 0))) ; Negate: Cond: $i8 <= 0  
(define-const var1863 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")] 
(assert true) ; Non Conditional
;(assert (var8_assertTrue/528204808 var1863 "total time interval of the sliding window should be positive")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive") 

(declare-const var1863!1 Bool)
(declare-const var3938 String)
(define-const var3057 Int (cast-from-Int-to-Int var747)) ; Statement: $l3 = (long) i0 
(define-const var1630 Int (mod var3067 var3057)) ; Statement: $l4 = l1 % $l3 
(define-const var871 Int (ite (> var1630 0) 1 (ite (< var1630 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
 ; Statement: if $b5 != 0 goto $z2 = 0 
(assert (not (= var871 0))) ; Cond: $b5 != 0 
(define-const var2967 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
;(assert (var8_assertTrue/528204808 var2967 "total time interval needs to be evenly divided")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided") 

(declare-const var2967!1 Bool)
(declare-const var627 String)
(declare-const var848!3 var3311)
(assert (not (= var848!3 null-var3311)))
(assert (= (paneCount/-729328706 var848!3) var747)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0 
(declare-const var848!4 var3311)
(assert (not (= var848!4 null-var3311)))
(assert (= (intervalInMs/-729328706 var848!4) var3067)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1 
(define-const var724 Int (cast-from-Int-to-Int var747)) ; Statement: $l6 = (long) i0 
(define-const var1906 Int (div var3067 var724)) ; Statement: $l7 = l1 / $l6 
(declare-const var848!5 var3311)
(assert (not (= var848!5 null-var3311)))
(assert (= (paneIntervalInMs/-729328706 var848!5) var1906)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7 
(define-const var2144 var1399 var1399-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicReferenceArray 
(assert true)
;(assert (<init>/-134673613 var2144 var747)) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0) 

(declare-const var2144!1 var1399)
(declare-const var747!1 Int)
(declare-const var848!6 var3311)
(assert (not (= var848!6 null-var3311)))
(assert (= (referenceArray/-729328706 var848!6) var2144!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3311-to-var3189=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.lang.Object), var2571-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), updateLock/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.locks.ReentrantLock), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var8_assertTrue/528204808=([boolean, java.lang.String], void), cast-from-Int-to-Int=([byte], int), paneCount/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], int), intervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), paneIntervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), var1399-init=([], java.util.concurrent.atomic.AtomicReferenceArray), <init>/-134673613=([java.util.concurrent.atomic.AtomicReferenceArray, int], void), referenceArray/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.atomic.AtomicReferenceArray)}
; {var3311=org.apache.dubbo.metrics.aggregate.SlidingWindow, var848=r0, var747=i0, var3067=l1, var3189=java.lang.Object, var2571=java.util.concurrent.locks.ReentrantLock, var1595=$r7, var3798=$z0, var883=$r8, var2329=$r3, var1402=$r4, var1163=$r5, var8=org.apache.dubbo.common.utils.Assert, var1710=$b2, var2467=$i8, var1863=$z1, var3938="total time interval of the sliding window should be positive", var3057=$l3, var1630=$l4, var871=$b5, var2967=$z2, var627="total time interval needs to be evenly divided", var724=$l6, var1906=$l7, var1399=java.util.concurrent.atomic.AtomicReferenceArray, var2144=$r9}
; {org.apache.dubbo.metrics.aggregate.SlidingWindow=var3311, r0=var848, i0=var747, l1=var3067, java.lang.Object=var3189, java.util.concurrent.locks.ReentrantLock=var2571, $r7=var1595, $z0=var3798, $r8=var883, $r3=var2329, $r4=var1402, $r5=var1163, org.apache.dubbo.common.utils.Assert=var8, $b2=var1710, $i8=var2467, $z1=var1863, "total time interval of the sliding window should be positive"=var3938, $l3=var3057, $l4=var1630, $b5=var871, $z2=var2967, "total time interval needs to be evenly divided"=var627, $l6=var724, $l7=var1906, java.util.concurrent.atomic.AtomicReferenceArray=var1399, $r9=var2144}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow;	i0 := @parameter0: int;	l1 := @parameter1: long;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r7 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7;	if i0 <= 0 goto $z0 = 0;	$z0 = 0;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5);	$b2 = l1 cmp 0L;	$i8 = (int) $b2;	if $i8 <= 0 goto $z1 = 0;	$z1 = 1;	goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")];	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive");	$l3 = (long) i0;	$l4 = l1 % $l3;	$b5 = $l4 cmp 0L;	if $b5 != 0 goto $z2 = 0;	$z2 = 0;	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided");	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1;	$l6 = (long) i0;	$l7 = l1 / $l6;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7;	$r9 = new java.util.concurrent.atomic.AtomicReferenceArray;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0);	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9;	return
;block_num 7