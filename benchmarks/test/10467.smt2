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

(declare-sort var2896 0)
(declare-sort var3992 0)
(declare-sort var665 0)
(declare-sort var1091 0)
(declare-sort var3047 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3992) void)
(declare-fun cast-from-var2896-to-var3992 (var2896) var3992)
(declare-fun var665-init () var665)
(declare-fun <init>/-377021476 (var665) void)
(declare-fun updateLock/-729328706 (var2896) var665)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1091_assertTrue/528204808 (Bool String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun paneCount/-729328706 (var2896) Int)
(declare-fun intervalInMs/-729328706 (var2896) Int)
(declare-fun paneIntervalInMs/-729328706 (var2896) Int)
(declare-fun var3047-init () var3047)
(declare-fun <init>/-134673613 (var3047 Int) void)
(declare-fun referenceArray/-729328706 (var2896) var3047)
(declare-const null-var2896 var2896)
(declare-const null-Int Int)
(declare-const var409 var2896) ; Statement: r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow 
(assert (not (= var409 null-var2896)))
(declare-const var1364 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1364 null-Int)))
(declare-const var2439 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var2439 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2896-to-var3992 var409))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var409!1 var2896)
(define-const var3213 var665 var665-init) ; Statement: $r7 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var3213)) ; Statement: specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var3213!1 var665)
(declare-const var409!2 var2896)
(assert (not (= var409!2 null-var2896)))
(assert (= (updateLock/-729328706 var409!2) var3213!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7 
 ; Statement: if i0 <= 0 goto $z0 = 0 
(assert (not (<= var1364 0))) ; Negate: Cond: i0 <= 0  
(define-const var3448 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= $r8 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var2385 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2385)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2385!1 String)
(assert (= var2385!1 ""))
(assert true)
(define-const var3976 String (append/672562846 var2385!1 "pane count is invalid: ")) ; Statement: $r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ") 
(declare-const var2385!2 String)
(assert (= var2385!2 (str.++ var2385!1 "pane count is invalid: ")))
(assert true)
(define-const var3500 String (append/-1001720160 var3976 var1364)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3976!1 String)
(assert (str.prefixof var3976 var3976!1))
(assert true)
(define-const var1471 String (toString/-2075883882 var3500)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1091_assertTrue/528204808 var3448 var1471)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5) 

(declare-const var3448!1 Bool)
(declare-const var1471!1 String)
(define-const var791 Int (ite (> var2439 0) 1 (ite (< var2439 0) -1 0))) ; Statement: $b2 = l1 cmp 0L 
(define-const var3887 Int (cast-from-Int-to-Int var791)) ; Statement: $i8 = (int) $b2 
 ; Statement: if $i8 <= 0 goto $z1 = 0 
(assert (not (<= var3887 0))) ; Negate: Cond: $i8 <= 0  
(define-const var3951 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")] 
(assert true) ; Non Conditional
;(assert (var1091_assertTrue/528204808 var3951 "total time interval of the sliding window should be positive")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive") 

(declare-const var3951!1 Bool)
(declare-const var465 String)
(define-const var3111 Int (cast-from-Int-to-Int var1364)) ; Statement: $l3 = (long) i0 
(define-const var2920 Int (mod var2439 var3111)) ; Statement: $l4 = l1 % $l3 
(define-const var3222 Int (ite (> var2920 0) 1 (ite (< var2920 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
 ; Statement: if $b5 != 0 goto $z2 = 0 
(assert (not (not (= var3222 0)))) ; Negate: Cond: $b5 != 0  
(define-const var2395 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided")] 
(assert true) ; Non Conditional
;(assert (var1091_assertTrue/528204808 var2395 "total time interval needs to be evenly divided")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided") 

(declare-const var2395!1 Bool)
(declare-const var2031 String)
(declare-const var409!3 var2896)
(assert (not (= var409!3 null-var2896)))
(assert (= (paneCount/-729328706 var409!3) var1364)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0 
(declare-const var409!4 var2896)
(assert (not (= var409!4 null-var2896)))
(assert (= (intervalInMs/-729328706 var409!4) var2439)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1 
(define-const var1784 Int (cast-from-Int-to-Int var1364)) ; Statement: $l6 = (long) i0 
(define-const var2668 Int (div var2439 var1784)) ; Statement: $l7 = l1 / $l6 
(declare-const var409!5 var2896)
(assert (not (= var409!5 null-var2896)))
(assert (= (paneIntervalInMs/-729328706 var409!5) var2668)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7 
(define-const var2837 var3047 var3047-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicReferenceArray 
(assert true)
;(assert (<init>/-134673613 var2837 var1364)) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0) 

(declare-const var2837!1 var3047)
(declare-const var1364!1 Int)
(declare-const var409!6 var2896)
(assert (not (= var409!6 null-var2896)))
(assert (= (referenceArray/-729328706 var409!6) var2837!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2896-to-var3992=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.lang.Object), var665-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), updateLock/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.locks.ReentrantLock), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1091_assertTrue/528204808=([boolean, java.lang.String], void), cast-from-Int-to-Int=([byte], int), paneCount/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], int), intervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), paneIntervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), var3047-init=([], java.util.concurrent.atomic.AtomicReferenceArray), <init>/-134673613=([java.util.concurrent.atomic.AtomicReferenceArray, int], void), referenceArray/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.atomic.AtomicReferenceArray)}
; {var2896=org.apache.dubbo.metrics.aggregate.SlidingWindow, var409=r0, var1364=i0, var2439=l1, var3992=java.lang.Object, var665=java.util.concurrent.locks.ReentrantLock, var3213=$r7, var3448=$z0, var2385=$r8, var3976=$r3, var3500=$r4, var1471=$r5, var1091=org.apache.dubbo.common.utils.Assert, var791=$b2, var3887=$i8, var3951=$z1, var465="total time interval of the sliding window should be positive", var3111=$l3, var2920=$l4, var3222=$b5, var2395=$z2, var2031="total time interval needs to be evenly divided", var1784=$l6, var2668=$l7, var3047=java.util.concurrent.atomic.AtomicReferenceArray, var2837=$r9}
; {org.apache.dubbo.metrics.aggregate.SlidingWindow=var2896, r0=var409, i0=var1364, l1=var2439, java.lang.Object=var3992, java.util.concurrent.locks.ReentrantLock=var665, $r7=var3213, $z0=var3448, $r8=var2385, $r3=var3976, $r4=var3500, $r5=var1471, org.apache.dubbo.common.utils.Assert=var1091, $b2=var791, $i8=var3887, $z1=var3951, "total time interval of the sliding window should be positive"=var465, $l3=var3111, $l4=var2920, $b5=var3222, $z2=var2395, "total time interval needs to be evenly divided"=var2031, $l6=var1784, $l7=var2668, java.util.concurrent.atomic.AtomicReferenceArray=var3047, $r9=var2837}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow;	i0 := @parameter0: int;	l1 := @parameter1: long;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r7 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7;	if i0 <= 0 goto $z0 = 0;	$z0 = 1;	goto [?= $r8 = new java.lang.StringBuilder];	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5);	$b2 = l1 cmp 0L;	$i8 = (int) $b2;	if $i8 <= 0 goto $z1 = 0;	$z1 = 1;	goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive")];	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive");	$l3 = (long) i0;	$l4 = l1 % $l3;	$b5 = $l4 cmp 0L;	if $b5 != 0 goto $z2 = 0;	$z2 = 1;	goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided")];	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided");	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1;	$l6 = (long) i0;	$l7 = l1 / $l6;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7;	$r9 = new java.util.concurrent.atomic.AtomicReferenceArray;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0);	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9;	return
;block_num 7