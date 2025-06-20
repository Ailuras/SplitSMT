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

(declare-sort var4 0)
(declare-sort var1002 0)
(declare-sort var2671 0)
(declare-sort var2699 0)
(declare-sort var2013 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1002) void)
(declare-fun cast-from-var4-to-var1002 (var4) var1002)
(declare-fun var2671-init () var2671)
(declare-fun <init>/-377021476 (var2671) void)
(declare-fun updateLock/-729328706 (var4) var2671)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2699_assertTrue/528204808 (Bool String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun paneCount/-729328706 (var4) Int)
(declare-fun intervalInMs/-729328706 (var4) Int)
(declare-fun paneIntervalInMs/-729328706 (var4) Int)
(declare-fun var2013-init () var2013)
(declare-fun <init>/-134673613 (var2013 Int) void)
(declare-fun referenceArray/-729328706 (var4) var2013)
(declare-const null-var4 var4)
(declare-const null-Int Int)
(declare-const var533 var4) ; Statement: r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow 
(assert (not (= var533 null-var4)))
(declare-const var3769 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3769 null-Int)))
(declare-const var1106 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var1106 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var4-to-var1002 var533))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var533!1 var4)
(define-const var1692 var2671 var2671-init) ; Statement: $r7 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var1692)) ; Statement: specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var1692!1 var2671)
(declare-const var533!2 var4)
(assert (not (= var533!2 null-var4)))
(assert (= (updateLock/-729328706 var533!2) var1692!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7 
 ; Statement: if i0 <= 0 goto $z0 = 0 
(assert (<= var3769 0)) ; Cond: i0 <= 0 
(define-const var2094 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
(define-const var747 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var747)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var747!1 String)
(assert (= var747!1 ""))
(assert true)
(define-const var941 String (append/672562846 var747!1 "pane count is invalid: ")) ; Statement: $r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ") 
(declare-const var747!2 String)
(assert (= var747!2 (str.++ var747!1 "pane count is invalid: ")))
(assert true)
(define-const var736 String (append/-1001720160 var941 var3769)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var941!1 String)
(assert (str.prefixof var941 var941!1))
(assert true)
(define-const var890 String (toString/-2075883882 var736)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2699_assertTrue/528204808 var2094 var890)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5) 

(declare-const var2094!1 Bool)
(declare-const var890!1 String)
(define-const var612 Int (ite (> var1106 0) 1 (ite (< var1106 0) -1 0))) ; Statement: $b2 = l1 cmp 0L 
(define-const var3465 Int (cast-from-Int-to-Int var612)) ; Statement: $i8 = (int) $b2 
 ; Statement: if $i8 <= 0 goto $z1 = 0 
(assert (not (<= var3465 0))) ; Negate: Cond: $i8 <= 0  
(define-const var3907 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")] 
(assert true) ; Non Conditional
;(assert (var2699_assertTrue/528204808 var3907 "total time interval of the sliding window should be positive")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive") 

(declare-const var3907!1 Bool)
(declare-const var3623 String)
(define-const var2457 Int (cast-from-Int-to-Int var3769)) ; Statement: $l3 = (long) i0 
(define-const var3468 Int (mod var1106 var2457)) ; Statement: $l4 = l1 % $l3 
(define-const var318 Int (ite (> var3468 0) 1 (ite (< var3468 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
 ; Statement: if $b5 != 0 goto $z2 = 0 
(assert (not (not (= var318 0)))) ; Negate: Cond: $b5 != 0  
(define-const var3245 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided")] 
(assert true) ; Non Conditional
;(assert (var2699_assertTrue/528204808 var3245 "total time interval needs to be evenly divided")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided") 

(declare-const var3245!1 Bool)
(declare-const var759 String)
(declare-const var533!3 var4)
(assert (not (= var533!3 null-var4)))
(assert (= (paneCount/-729328706 var533!3) var3769)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0 
(declare-const var533!4 var4)
(assert (not (= var533!4 null-var4)))
(assert (= (intervalInMs/-729328706 var533!4) var1106)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1 
(define-const var1526 Int (cast-from-Int-to-Int var3769)) ; Statement: $l6 = (long) i0 
(define-const var3597 Int (div var1106 var1526)) ; Statement: $l7 = l1 / $l6 
(declare-const var533!5 var4)
(assert (not (= var533!5 null-var4)))
(assert (= (paneIntervalInMs/-729328706 var533!5) var3597)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7 
(define-const var1350 var2013 var2013-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicReferenceArray 
(assert true)
;(assert (<init>/-134673613 var1350 var3769)) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0) 

(declare-const var1350!1 var2013)
(declare-const var3769!1 Int)
(declare-const var533!6 var4)
(assert (not (= var533!6 null-var4)))
(assert (= (referenceArray/-729328706 var533!6) var1350!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var4-to-var1002=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.lang.Object), var2671-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), updateLock/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.locks.ReentrantLock), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2699_assertTrue/528204808=([boolean, java.lang.String], void), cast-from-Int-to-Int=([byte], int), paneCount/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], int), intervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), paneIntervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), var2013-init=([], java.util.concurrent.atomic.AtomicReferenceArray), <init>/-134673613=([java.util.concurrent.atomic.AtomicReferenceArray, int], void), referenceArray/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.atomic.AtomicReferenceArray)}
; {var4=org.apache.dubbo.metrics.aggregate.SlidingWindow, var533=r0, var3769=i0, var1106=l1, var1002=java.lang.Object, var2671=java.util.concurrent.locks.ReentrantLock, var1692=$r7, var2094=$z0, var747=$r8, var941=$r3, var736=$r4, var890=$r5, var2699=org.apache.dubbo.common.utils.Assert, var612=$b2, var3465=$i8, var3907=$z1, var3623="total time interval of the sliding window should be positive", var2457=$l3, var3468=$l4, var318=$b5, var3245=$z2, var759="total time interval needs to be evenly divided", var1526=$l6, var3597=$l7, var2013=java.util.concurrent.atomic.AtomicReferenceArray, var1350=$r9}
; {org.apache.dubbo.metrics.aggregate.SlidingWindow=var4, r0=var533, i0=var3769, l1=var1106, java.lang.Object=var1002, java.util.concurrent.locks.ReentrantLock=var2671, $r7=var1692, $z0=var2094, $r8=var747, $r3=var941, $r4=var736, $r5=var890, org.apache.dubbo.common.utils.Assert=var2699, $b2=var612, $i8=var3465, $z1=var3907, "total time interval of the sliding window should be positive"=var3623, $l3=var2457, $l4=var3468, $b5=var318, $z2=var3245, "total time interval needs to be evenly divided"=var759, $l6=var1526, $l7=var3597, java.util.concurrent.atomic.AtomicReferenceArray=var2013, $r9=var1350}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow;	i0 := @parameter0: int;	l1 := @parameter1: long;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r7 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7;	if i0 <= 0 goto $z0 = 0;	$z0 = 0;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5);	$b2 = l1 cmp 0L;	$i8 = (int) $b2;	if $i8 <= 0 goto $z1 = 0;	$z1 = 1;	goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")];	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive");	$l3 = (long) i0;	$l4 = l1 % $l3;	$b5 = $l4 cmp 0L;	if $b5 != 0 goto $z2 = 0;	$z2 = 1;	goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided")];	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided");	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1;	$l6 = (long) i0;	$l7 = l1 / $l6;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7;	$r9 = new java.util.concurrent.atomic.AtomicReferenceArray;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0);	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9;	return
;block_num 7