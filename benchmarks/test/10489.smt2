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

(declare-sort var608 0)
(declare-sort var2660 0)
(declare-sort var2289 0)
(declare-sort var2333 0)
(declare-sort var573 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2660) void)
(declare-fun cast-from-var608-to-var2660 (var608) var2660)
(declare-fun var2289-init () var2289)
(declare-fun <init>/-377021476 (var2289) void)
(declare-fun updateLock/-729328706 (var608) var2289)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2333_assertTrue/528204808 (Bool String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun paneCount/-729328706 (var608) Int)
(declare-fun intervalInMs/-729328706 (var608) Int)
(declare-fun paneIntervalInMs/-729328706 (var608) Int)
(declare-fun var573-init () var573)
(declare-fun <init>/-134673613 (var573 Int) void)
(declare-fun referenceArray/-729328706 (var608) var573)
(declare-const null-var608 var608)
(declare-const null-Int Int)
(declare-const var317 var608) ; Statement: r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow 
(assert (not (= var317 null-var608)))
(declare-const var3188 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3188 null-Int)))
(declare-const var1524 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var1524 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var608-to-var2660 var317))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var317!1 var608)
(define-const var449 var2289 var2289-init) ; Statement: $r7 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var449)) ; Statement: specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var449!1 var2289)
(declare-const var317!2 var608)
(assert (not (= var317!2 null-var608)))
(assert (= (updateLock/-729328706 var317!2) var449!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7 
 ; Statement: if i0 <= 0 goto $z0 = 0 
(assert (not (<= var3188 0))) ; Negate: Cond: i0 <= 0  
(define-const var3632 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= $r8 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var257 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var257)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var257!1 String)
(assert (= var257!1 ""))
(assert true)
(define-const var135 String (append/672562846 var257!1 "pane count is invalid: ")) ; Statement: $r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ") 
(declare-const var257!2 String)
(assert (= var257!2 (str.++ var257!1 "pane count is invalid: ")))
(assert true)
(define-const var1999 String (append/-1001720160 var135 var3188)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var135!1 String)
(assert (str.prefixof var135 var135!1))
(assert true)
(define-const var2988 String (toString/-2075883882 var1999)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2333_assertTrue/528204808 var3632 var2988)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5) 

(declare-const var3632!1 Bool)
(declare-const var2988!1 String)
(define-const var231 Int (ite (> var1524 0) 1 (ite (< var1524 0) -1 0))) ; Statement: $b2 = l1 cmp 0L 
(define-const var1417 Int (cast-from-Int-to-Int var231)) ; Statement: $i8 = (int) $b2 
 ; Statement: if $i8 <= 0 goto $z1 = 0 
(assert (<= var1417 0)) ; Cond: $i8 <= 0 
(define-const var3905 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
;(assert (var2333_assertTrue/528204808 var3905 "total time interval of the sliding window should be positive")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive") 

(declare-const var3905!1 Bool)
(declare-const var1259 String)
(define-const var397 Int (cast-from-Int-to-Int var3188)) ; Statement: $l3 = (long) i0 
(define-const var58 Int (mod var1524 var397)) ; Statement: $l4 = l1 % $l3 
(define-const var2184 Int (ite (> var58 0) 1 (ite (< var58 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
 ; Statement: if $b5 != 0 goto $z2 = 0 
(assert (not (not (= var2184 0)))) ; Negate: Cond: $b5 != 0  
(define-const var1684 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided")] 
(assert true) ; Non Conditional
;(assert (var2333_assertTrue/528204808 var1684 "total time interval needs to be evenly divided")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided") 

(declare-const var1684!1 Bool)
(declare-const var3186 String)
(declare-const var317!3 var608)
(assert (not (= var317!3 null-var608)))
(assert (= (paneCount/-729328706 var317!3) var3188)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0 
(declare-const var317!4 var608)
(assert (not (= var317!4 null-var608)))
(assert (= (intervalInMs/-729328706 var317!4) var1524)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1 
(define-const var1178 Int (cast-from-Int-to-Int var3188)) ; Statement: $l6 = (long) i0 
(define-const var3950 Int (div var1524 var1178)) ; Statement: $l7 = l1 / $l6 
(declare-const var317!5 var608)
(assert (not (= var317!5 null-var608)))
(assert (= (paneIntervalInMs/-729328706 var317!5) var3950)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7 
(define-const var2633 var573 var573-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicReferenceArray 
(assert true)
;(assert (<init>/-134673613 var2633 var3188)) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0) 

(declare-const var2633!1 var573)
(declare-const var3188!1 Int)
(declare-const var317!6 var608)
(assert (not (= var317!6 null-var608)))
(assert (= (referenceArray/-729328706 var317!6) var2633!1)) ; Statement: r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var608-to-var2660=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.lang.Object), var2289-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), updateLock/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.locks.ReentrantLock), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2333_assertTrue/528204808=([boolean, java.lang.String], void), cast-from-Int-to-Int=([byte], int), paneCount/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], int), intervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), paneIntervalInMs/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], long), var573-init=([], java.util.concurrent.atomic.AtomicReferenceArray), <init>/-134673613=([java.util.concurrent.atomic.AtomicReferenceArray, int], void), referenceArray/-729328706=([org.apache.dubbo.metrics.aggregate.SlidingWindow], java.util.concurrent.atomic.AtomicReferenceArray)}
; {var608=org.apache.dubbo.metrics.aggregate.SlidingWindow, var317=r0, var3188=i0, var1524=l1, var2660=java.lang.Object, var2289=java.util.concurrent.locks.ReentrantLock, var449=$r7, var3632=$z0, var257=$r8, var135=$r3, var1999=$r4, var2988=$r5, var2333=org.apache.dubbo.common.utils.Assert, var231=$b2, var1417=$i8, var3905=$z1, var1259="total time interval of the sliding window should be positive", var397=$l3, var58=$l4, var2184=$b5, var1684=$z2, var3186="total time interval needs to be evenly divided", var1178=$l6, var3950=$l7, var573=java.util.concurrent.atomic.AtomicReferenceArray, var2633=$r9}
; {org.apache.dubbo.metrics.aggregate.SlidingWindow=var608, r0=var317, i0=var3188, l1=var1524, java.lang.Object=var2660, java.util.concurrent.locks.ReentrantLock=var2289, $r7=var449, $z0=var3632, $r8=var257, $r3=var135, $r4=var1999, $r5=var2988, org.apache.dubbo.common.utils.Assert=var2333, $b2=var231, $i8=var1417, $z1=var3905, "total time interval of the sliding window should be positive"=var1259, $l3=var397, $l4=var58, $b5=var2184, $z2=var1684, "total time interval needs to be evenly divided"=var3186, $l6=var1178, $l7=var3950, java.util.concurrent.atomic.AtomicReferenceArray=var573, $r9=var2633}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.aggregate.SlidingWindow;	i0 := @parameter0: int;	l1 := @parameter1: long;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r7 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r7.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.locks.ReentrantLock updateLock> = $r7;	if i0 <= 0 goto $z0 = 0;	$z0 = 1;	goto [?= $r8 = new java.lang.StringBuilder];	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pane count is invalid: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z0, $r5);	$b2 = l1 cmp 0L;	$i8 = (int) $b2;	if $i8 <= 0 goto $z1 = 0;	$z1 = 0;	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z1, "total time interval of the sliding window should be positive");	$l3 = (long) i0;	$l4 = l1 % $l3;	$b5 = $l4 cmp 0L;	if $b5 != 0 goto $z2 = 0;	$z2 = 1;	goto [?= staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided")];	staticinvoke <org.apache.dubbo.common.utils.Assert: void assertTrue(boolean,java.lang.String)>($z2, "total time interval needs to be evenly divided");	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: int paneCount> = i0;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long intervalInMs> = l1;	$l6 = (long) i0;	$l7 = l1 / $l6;	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: long paneIntervalInMs> = $l7;	$r9 = new java.util.concurrent.atomic.AtomicReferenceArray;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicReferenceArray: void <init>(int)>(i0);	r0.<org.apache.dubbo.metrics.aggregate.SlidingWindow: java.util.concurrent.atomic.AtomicReferenceArray referenceArray> = $r9;	return
;block_num 7