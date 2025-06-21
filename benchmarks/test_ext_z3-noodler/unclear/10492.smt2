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

(declare-sort var1703 0)
(declare-sort var1489 0)
(declare-sort var315 0)
(declare-sort var3085 0)
(declare-sort var2229 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1489) void)
(declare-fun cast-from-var1703-to-var1489 (var1703) var1489)
(declare-fun var315-init () var315)
(declare-fun <init>/-377021476 (var315) void)
(declare-fun updateLock/-729328706 (var1703) var315)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3085_assertTrue/528204808 (Bool String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun paneCount/-729328706 (var1703) Int)
(declare-fun intervalInMs/-729328706 (var1703) Int)
(declare-fun paneIntervalInMs/-729328706 (var1703) Int)
(declare-fun var2229-init () var2229)
(declare-fun <init>/-134673613 (var2229 Int) void)
(declare-fun referenceArray/-729328706 (var1703) var2229)
(declare-const null-var1703 var1703)
(declare-const null-Int Int)
(declare-const var2316 var1703) ; Statement: r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow 
(assert (not (= var2316 null-var1703)))
(declare-const var848 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var848 null-Int)))
(declare-const var1440 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var1440 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1703-to-var1489 var2316))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2316!1 var1703)
(define-const var3006 var315 var315-init) ; Statement: $r7 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var3006)) ; Statement: specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var3006!1 var315)
(declare-const var2316!2 var1703)
(assert (not (= var2316!2 null-var1703)))
(assert (= (updateLock/-729328706 var2316!2) var3006!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7 
 ; Statement: if i0 <= 0 goto $z0 = 0 
(assert (not (<= var848 0))) ; Negate: Cond: i0 <= 0  
(define-const var701 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= $r8 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var2521 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2521)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2521!1 String)
(assert (= var2521!1 ""))
(assert true)
(define-const var2662 String (append/672562846 var2521!1 "pane count is invalid: ")) ; Statement: $r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ") 
(declare-const var2521!2 String)
(assert (= var2521!2 (str.++ var2521!1 "pane count is invalid: ")))
(assert true)
(define-const var3211 String (append/-1001720160 var2662 var848)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2662!1 String)
(assert (str.prefixof var2662 var2662!1))
(assert true)
(define-const var553 String (toString/-2075883882 var3211)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3085_assertTrue/528204808 var701 var553)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5) 

(declare-const var701!1 Bool)
(declare-const var553!1 String)
(define-const var2284 Int (ite (> var1440 0) 1 (ite (< var1440 0) -1 0))) ; Statement: $b2 = l1 cmp 0L 
(define-const var529 Int (cast-from-Int-to-Int var2284)) ; Statement: $i8 = (int) $b2 
 ; Statement: if $i8 <= 0 goto $z1 = 0 
(assert (<= var529 0)) ; Cond: $i8 <= 0 
(define-const var1464 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
;(assert (var3085_assertTrue/528204808 var1464 "total time interval of the sliding window should be positive")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive") 

(declare-const var1464!1 Bool)
(declare-const var808 String)
(define-const var3962 Int (cast-from-Int-to-Int var848)) ; Statement: $l3 = (long) i0 
(define-const var379 Int (mod var1440 var3962)) ; Statement: $l4 = l1 % $l3 
(define-const var2439 Int (ite (> var379 0) 1 (ite (< var379 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
 ; Statement: if $b5 != 0 goto $z2 = 0 
(assert (not (= var2439 0))) ; Cond: $b5 != 0 
(define-const var3300 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
;(assert (var3085_assertTrue/528204808 var3300 "total time interval needs to be evenly divided")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided") 

(declare-const var3300!1 Bool)
(declare-const var1006 String)
(declare-const var2316!3 var1703)
(assert (not (= var2316!3 null-var1703)))
(assert (= (paneCount/-729328706 var2316!3) var848)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0 
(declare-const var2316!4 var1703)
(assert (not (= var2316!4 null-var1703)))
(assert (= (intervalInMs/-729328706 var2316!4) var1440)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1 
(define-const var3707 Int (cast-from-Int-to-Int var848)) ; Statement: $l6 = (long) i0 
(define-const var1992 Int (div var1440 var3707)) ; Statement: $l7 = l1 / $l6 
(declare-const var2316!5 var1703)
(assert (not (= var2316!5 null-var1703)))
(assert (= (paneIntervalInMs/-729328706 var2316!5) var1992)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7 
(define-const var3582 var2229 var2229-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicReferenceArray 
(assert true)
;(assert (<init>/-134673613 var3582 var848)) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0) 

(declare-const var3582!1 var2229)
(declare-const var848!1 Int)
(declare-const var2316!6 var1703)
(assert (not (= var2316!6 null-var1703)))
(assert (= (referenceArray/-729328706 var2316!6) var3582!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1703-to-var1489=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.lang.Object), var315-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), updateLock/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.locks.ReentrantLock), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3085_assertTrue/528204808=([boolean, java.lang.String], void), cast-from-Int-to-Int=([byte], int), paneCount/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], int), intervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), paneIntervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), var2229-init=([], java.util.concurrent.atomic.AtomicReferenceArray), <init>/-134673613=([java.util.concurrent.atomic.AtomicReferenceArray, int], void), referenceArray/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.atomic.AtomicReferenceArray)}
; {var1703=org.apache.dubbo.metrics.aggregate.SlidingWindow, var2316=r0, var848=i0, var1440=l1, var1489=java.lang.Object, var315=java.util.concurrent.locks.ReentrantLock, var3006=$r7, var701=$z0, var2521=$r8, var2662=$r3, var3211=$r4, var553=$r5, var3085=org.apache.dubbo.common.utils.Assert, var2284=$b2, var529=$i8, var1464=$z1, var808="total time interval of the sliding window should be positive", var3962=$l3, var379=$l4, var2439=$b5, var3300=$z2, var1006="total time interval needs to be evenly divided", var3707=$l6, var1992=$l7, var2229=java.util.concurrent.atomic.AtomicReferenceArray, var3582=$r9}
; {org.apache.dubbo.metrics.aggregate.SlidingWindow=var1703, r0=var2316, i0=var848, l1=var1440, java.lang.Object=var1489, java.util.concurrent.locks.ReentrantLock=var315, $r7=var3006, $z0=var701, $r8=var2521, $r3=var2662, $r4=var3211, $r5=var553, org.apache.dubbo.common.utils.Assert=var3085, $b2=var2284, $i8=var529, $z1=var1464, "total time interval of the sliding window should be positive"=var808, $l3=var3962, $l4=var379, $b5=var2439, $z2=var3300, "total time interval needs to be evenly divided"=var1006, $l6=var3707, $l7=var1992, java.util.concurrent.atomic.AtomicReferenceArray=var2229, $r9=var3582}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow;	i0 := @parameter0: int;	l1 := @parameter1: long;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r7 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7;	if i0 <= 0 goto $z0 = 0;	$z0 = 1;	goto [?= $r8 = new java.lang.StringBuilder];	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5);	$b2 = l1 cmp 0L;	$i8 = (int) $b2;	if $i8 <= 0 goto $z1 = 0;	$z1 = 0;	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive");	$l3 = (long) i0;	$l4 = l1 % $l3;	$b5 = $l4 cmp 0L;	if $b5 != 0 goto $z2 = 0;	$z2 = 0;	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided");	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1;	$l6 = (long) i0;	$l7 = l1 / $l6;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7;	$r9 = new java.util.concurrent.atomic.AtomicReferenceArray;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0);	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9;	return
;block_num 7