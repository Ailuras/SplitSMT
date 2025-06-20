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

(declare-sort var2798 0)
(declare-sort var2711 0)
(declare-sort var1821 0)
(declare-sort var399 0)
(declare-sort var2982 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2711) void)
(declare-fun cast-from-var2798-to-var2711 (var2798) var2711)
(declare-fun var1821-init () var1821)
(declare-fun <init>/-377021476 (var1821) void)
(declare-fun updateLock/-729328706 (var2798) var1821)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var399_assertTrue/528204808 (Bool String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun paneCount/-729328706 (var2798) Int)
(declare-fun intervalInMs/-729328706 (var2798) Int)
(declare-fun paneIntervalInMs/-729328706 (var2798) Int)
(declare-fun var2982-init () var2982)
(declare-fun <init>/-134673613 (var2982 Int) void)
(declare-fun referenceArray/-729328706 (var2798) var2982)
(declare-const null-var2798 var2798)
(declare-const null-Int Int)
(declare-const var2208 var2798) ; Statement: r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow 
(assert (not (= var2208 null-var2798)))
(declare-const var883 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var883 null-Int)))
(declare-const var919 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var919 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2798-to-var2711 var2208))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2208!1 var2798)
(define-const var2910 var1821 var1821-init) ; Statement: $r7 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var2910)) ; Statement: specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var2910!1 var1821)
(declare-const var2208!2 var2798)
(assert (not (= var2208!2 null-var2798)))
(assert (= (updateLock/-729328706 var2208!2) var2910!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7 
 ; Statement: if i0 <= 0 goto $z0 = 0 
(assert (<= var883 0)) ; Cond: i0 <= 0 
(define-const var1770 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
(define-const var1678 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1678)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1678!1 String)
(assert (= var1678!1 ""))
(assert true)
(define-const var303 String (append/672562846 var1678!1 "pane count is invalid: ")) ; Statement: $r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ") 
(declare-const var1678!2 String)
(assert (= var1678!2 (str.++ var1678!1 "pane count is invalid: ")))
(assert true)
(define-const var986 String (append/-1001720160 var303 var883)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var303!1 String)
(assert (str.prefixof var303 var303!1))
(assert true)
(define-const var3248 String (toString/-2075883882 var986)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var399_assertTrue/528204808 var1770 var3248)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5) 

(declare-const var1770!1 Bool)
(declare-const var3248!1 String)
(define-const var2861 Int (ite (> var919 0) 1 (ite (< var919 0) -1 0))) ; Statement: $b2 = l1 cmp 0L 
(define-const var3526 Int (cast-from-Int-to-Int var2861)) ; Statement: $i8 = (int) $b2 
 ; Statement: if $i8 <= 0 goto $z1 = 0 
(assert (<= var3526 0)) ; Cond: $i8 <= 0 
(define-const var3971 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
;(assert (var399_assertTrue/528204808 var3971 "total time interval of the sliding window should be positive")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive") 

(declare-const var3971!1 Bool)
(declare-const var2870 String)
(define-const var976 Int (cast-from-Int-to-Int var883)) ; Statement: $l3 = (long) i0 
(define-const var3645 Int (mod var919 var976)) ; Statement: $l4 = l1 % $l3 
(define-const var2161 Int (ite (> var3645 0) 1 (ite (< var3645 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
 ; Statement: if $b5 != 0 goto $z2 = 0 
(assert (not (= var2161 0))) ; Cond: $b5 != 0 
(define-const var3105 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
;(assert (var399_assertTrue/528204808 var3105 "total time interval needs to be evenly divided")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided") 

(declare-const var3105!1 Bool)
(declare-const var3687 String)
(declare-const var2208!3 var2798)
(assert (not (= var2208!3 null-var2798)))
(assert (= (paneCount/-729328706 var2208!3) var883)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0 
(declare-const var2208!4 var2798)
(assert (not (= var2208!4 null-var2798)))
(assert (= (intervalInMs/-729328706 var2208!4) var919)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1 
(define-const var1888 Int (cast-from-Int-to-Int var883)) ; Statement: $l6 = (long) i0 
(define-const var1539 Int (div var919 var1888)) ; Statement: $l7 = l1 / $l6 
(declare-const var2208!5 var2798)
(assert (not (= var2208!5 null-var2798)))
(assert (= (paneIntervalInMs/-729328706 var2208!5) var1539)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7 
(define-const var2618 var2982 var2982-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicReferenceArray 
(assert true)
;(assert (<init>/-134673613 var2618 var883)) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0) 

(declare-const var2618!1 var2982)
(declare-const var883!1 Int)
(declare-const var2208!6 var2798)
(assert (not (= var2208!6 null-var2798)))
(assert (= (referenceArray/-729328706 var2208!6) var2618!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2798-to-var2711=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.lang.Object), var1821-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), updateLock/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.locks.ReentrantLock), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var399_assertTrue/528204808=([boolean, java.lang.String], void), cast-from-Int-to-Int=([byte], int), paneCount/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], int), intervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), paneIntervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), var2982-init=([], java.util.concurrent.atomic.AtomicReferenceArray), <init>/-134673613=([java.util.concurrent.atomic.AtomicReferenceArray, int], void), referenceArray/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.atomic.AtomicReferenceArray)}
; {var2798=org.apache.dubbo.metrics.aggregate.SlidingWindow, var2208=r0, var883=i0, var919=l1, var2711=java.lang.Object, var1821=java.util.concurrent.locks.ReentrantLock, var2910=$r7, var1770=$z0, var1678=$r8, var303=$r3, var986=$r4, var3248=$r5, var399=org.apache.dubbo.common.utils.Assert, var2861=$b2, var3526=$i8, var3971=$z1, var2870="total time interval of the sliding window should be positive", var976=$l3, var3645=$l4, var2161=$b5, var3105=$z2, var3687="total time interval needs to be evenly divided", var1888=$l6, var1539=$l7, var2982=java.util.concurrent.atomic.AtomicReferenceArray, var2618=$r9}
; {org.apache.dubbo.metrics.aggregate.SlidingWindow=var2798, r0=var2208, i0=var883, l1=var919, java.lang.Object=var2711, java.util.concurrent.locks.ReentrantLock=var1821, $r7=var2910, $z0=var1770, $r8=var1678, $r3=var303, $r4=var986, $r5=var3248, org.apache.dubbo.common.utils.Assert=var399, $b2=var2861, $i8=var3526, $z1=var3971, "total time interval of the sliding window should be positive"=var2870, $l3=var976, $l4=var3645, $b5=var2161, $z2=var3105, "total time interval needs to be evenly divided"=var3687, $l6=var1888, $l7=var1539, java.util.concurrent.atomic.AtomicReferenceArray=var2982, $r9=var2618}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow;	i0 := @parameter0: int;	l1 := @parameter1: long;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r7 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7;	if i0 <= 0 goto $z0 = 0;	$z0 = 0;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5);	$b2 = l1 cmp 0L;	$i8 = (int) $b2;	if $i8 <= 0 goto $z1 = 0;	$z1 = 0;	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive");	$l3 = (long) i0;	$l4 = l1 % $l3;	$b5 = $l4 cmp 0L;	if $b5 != 0 goto $z2 = 0;	$z2 = 0;	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided");	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1;	$l6 = (long) i0;	$l7 = l1 / $l6;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7;	$r9 = new java.util.concurrent.atomic.AtomicReferenceArray;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0);	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9;	return
;block_num 7