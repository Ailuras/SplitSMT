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

(declare-sort var1097 0)
(declare-sort var1066 0)
(declare-sort var2956 0)
(declare-sort var2745 0)
(declare-sort var444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1066) void)
(declare-fun cast-from-var1097-to-var1066 (var1097) var1066)
(declare-fun var2956-init () var2956)
(declare-fun <init>/-377021476 (var2956) void)
(declare-fun updateLock/-729328706 (var1097) var2956)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2745_assertTrue/528204808 (Bool String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun paneCount/-729328706 (var1097) Int)
(declare-fun intervalInMs/-729328706 (var1097) Int)
(declare-fun paneIntervalInMs/-729328706 (var1097) Int)
(declare-fun var444-init () var444)
(declare-fun <init>/-134673613 (var444 Int) void)
(declare-fun referenceArray/-729328706 (var1097) var444)
(declare-const null-var1097 var1097)
(declare-const null-Int Int)
(declare-const var3002 var1097) ; Statement: r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow 
(assert (not (= var3002 null-var1097)))
(declare-const var294 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var294 null-Int)))
(declare-const var338 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var338 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1097-to-var1066 var3002))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3002!1 var1097)
(define-const var325 var2956 var2956-init) ; Statement: $r7 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var325)) ; Statement: specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var325!1 var2956)
(declare-const var3002!2 var1097)
(assert (not (= var3002!2 null-var1097)))
(assert (= (updateLock/-729328706 var3002!2) var325!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7 
 ; Statement: if i0 <= 0 goto $z0 = 0 
(assert (not (<= var294 0))) ; Negate: Cond: i0 <= 0  
(define-const var1609 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= $r8 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var187 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var187)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var187!1 String)
(assert (= var187!1 ""))
(assert true)
(define-const var233 String (append/672562846 var187!1 "pane count is invalid: ")) ; Statement: $r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ") 
(declare-const var187!2 String)
(assert (= var187!2 (str.++ var187!1 "pane count is invalid: ")))
(assert true)
(define-const var375 String (append/-1001720160 var233 var294)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var233!1 String)
(assert (str.prefixof var233 var233!1))
(assert true)
(define-const var2958 String (toString/-2075883882 var375)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2745_assertTrue/528204808 var1609 var2958)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5) 

(declare-const var1609!1 Bool)
(declare-const var2958!1 String)
(define-const var3278 Int (ite (> var338 0) 1 (ite (< var338 0) -1 0))) ; Statement: $b2 = l1 cmp 0L 
(define-const var3150 Int (cast-from-Int-to-Int var3278)) ; Statement: $i8 = (int) $b2 
 ; Statement: if $i8 <= 0 goto $z1 = 0 
(assert (not (<= var3150 0))) ; Negate: Cond: $i8 <= 0  
(define-const var2706 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")] 
(assert true) ; Non Conditional
;(assert (var2745_assertTrue/528204808 var2706 "total time interval of the sliding window should be positive")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive") 

(declare-const var2706!1 Bool)
(declare-const var501 String)
(define-const var2237 Int (cast-from-Int-to-Int var294)) ; Statement: $l3 = (long) i0 
(define-const var3202 Int (mod var338 var2237)) ; Statement: $l4 = l1 % $l3 
(define-const var1188 Int (ite (> var3202 0) 1 (ite (< var3202 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
 ; Statement: if $b5 != 0 goto $z2 = 0 
(assert (not (= var1188 0))) ; Cond: $b5 != 0 
(define-const var1266 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
;(assert (var2745_assertTrue/528204808 var1266 "total time interval needs to be evenly divided")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided") 

(declare-const var1266!1 Bool)
(declare-const var2400 String)
(declare-const var3002!3 var1097)
(assert (not (= var3002!3 null-var1097)))
(assert (= (paneCount/-729328706 var3002!3) var294)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0 
(declare-const var3002!4 var1097)
(assert (not (= var3002!4 null-var1097)))
(assert (= (intervalInMs/-729328706 var3002!4) var338)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1 
(define-const var406 Int (cast-from-Int-to-Int var294)) ; Statement: $l6 = (long) i0 
(define-const var469 Int (div var338 var406)) ; Statement: $l7 = l1 / $l6 
(declare-const var3002!5 var1097)
(assert (not (= var3002!5 null-var1097)))
(assert (= (paneIntervalInMs/-729328706 var3002!5) var469)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7 
(define-const var3513 var444 var444-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicReferenceArray 
(assert true)
;(assert (<init>/-134673613 var3513 var294)) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0) 

(declare-const var3513!1 var444)
(declare-const var294!1 Int)
(declare-const var3002!6 var1097)
(assert (not (= var3002!6 null-var1097)))
(assert (= (referenceArray/-729328706 var3002!6) var3513!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1097-to-var1066=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.lang.Object), var2956-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), updateLock/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.locks.ReentrantLock), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2745_assertTrue/528204808=([boolean, java.lang.String], void), cast-from-Int-to-Int=([byte], int), paneCount/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], int), intervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), paneIntervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), var444-init=([], java.util.concurrent.atomic.AtomicReferenceArray), <init>/-134673613=([java.util.concurrent.atomic.AtomicReferenceArray, int], void), referenceArray/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.atomic.AtomicReferenceArray)}
; {var1097=org.apache.dubbo.metrics.aggregate.SlidingWindow, var3002=r0, var294=i0, var338=l1, var1066=java.lang.Object, var2956=java.util.concurrent.locks.ReentrantLock, var325=$r7, var1609=$z0, var187=$r8, var233=$r3, var375=$r4, var2958=$r5, var2745=org.apache.dubbo.common.utils.Assert, var3278=$b2, var3150=$i8, var2706=$z1, var501="total time interval of the sliding window should be positive", var2237=$l3, var3202=$l4, var1188=$b5, var1266=$z2, var2400="total time interval needs to be evenly divided", var406=$l6, var469=$l7, var444=java.util.concurrent.atomic.AtomicReferenceArray, var3513=$r9}
; {org.apache.dubbo.metrics.aggregate.SlidingWindow=var1097, r0=var3002, i0=var294, l1=var338, java.lang.Object=var1066, java.util.concurrent.locks.ReentrantLock=var2956, $r7=var325, $z0=var1609, $r8=var187, $r3=var233, $r4=var375, $r5=var2958, org.apache.dubbo.common.utils.Assert=var2745, $b2=var3278, $i8=var3150, $z1=var2706, "total time interval of the sliding window should be positive"=var501, $l3=var2237, $l4=var3202, $b5=var1188, $z2=var1266, "total time interval needs to be evenly divided"=var2400, $l6=var406, $l7=var469, java.util.concurrent.atomic.AtomicReferenceArray=var444, $r9=var3513}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow;	i0 := @parameter0: int;	l1 := @parameter1: long;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r7 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7;	if i0 <= 0 goto $z0 = 0;	$z0 = 1;	goto [?= $r8 = new java.lang.StringBuilder];	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5);	$b2 = l1 cmp 0L;	$i8 = (int) $b2;	if $i8 <= 0 goto $z1 = 0;	$z1 = 1;	goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")];	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive");	$l3 = (long) i0;	$l4 = l1 % $l3;	$b5 = $l4 cmp 0L;	if $b5 != 0 goto $z2 = 0;	$z2 = 0;	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided");	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1;	$l6 = (long) i0;	$l7 = l1 / $l6;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7;	$r9 = new java.util.concurrent.atomic.AtomicReferenceArray;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0);	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9;	return
;block_num 7