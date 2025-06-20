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

(declare-sort var2460 0)
(declare-sort var1084 0)
(declare-sort var1787 0)
(declare-sort var3627 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1084) void)
(declare-fun cast-from-var2460-to-var1084 (var2460) var1084)
(declare-fun curSize/-1034741791 (var2460) Int)
(declare-fun var1787-init () var1787)
(declare-fun <init>/-377021476 (var1787) void)
(declare-fun lock/-1034741791 (var2460) var1787)
(declare-fun var3627-init () var3627)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3627 String) void)
(declare-const null-var2460 var2460)
(declare-const null-Int Int)
(declare-const null-Float32 Float32)
(declare-const var1152 var2460) ; Statement: r0 := @this: org.apache.dubbo.common.utils.LFUCache 
(assert (not (= var1152 null-var2460)))
(declare-const var807 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var807 null-Int)))
(declare-const var1753 Float32) ; Statement: f0 := @parameter1: float 
(assert (not (= var1753 null-Float32)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2460-to-var1084 var1152))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1152!1 var2460)
(declare-const var1152!2 var2460)
(assert (not (= var1152!2 null-var2460)))
(assert (= (curSize/-1034741791 var1152!2) 0)) ; Statement: r0.<org.apache.dubbo.common.utils.LFUCache: int curSize> = 0 
(define-const var2599 var1787 var1787-init) ; Statement: $r24 = new java.util.concurrent.locks.ReentrantLock 
(assert true)
;(assert (<init>/-377021476 var2599)) ; Statement: specialinvoke $r24.<java.util.concurrent.locks.ReentrantLock: void <init>()>() 

(declare-const var2599!1 var1787)
(declare-const var1152!3 var2460)
(assert (not (= var1152!3 null-var2460)))
(assert (= (lock/-1034741791 var1152!3) var2599!1)) ; Statement: r0.<org.apache.dubbo.common.utils.LFUCache: java.util.concurrent.locks.ReentrantLock lock> = $r24 
 ; Statement: if i0 > 0 goto $b1 = f0 cmpg 1.0F 
(assert (not (> var807 0))) ; Negate: Cond: i0 > 0  
(define-const var2746 var3627 var3627-init) ; Statement: $r26 = new java.lang.IllegalArgumentException 
(define-const var2562 String String-init) ; Statement: $r25 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2562)) ; Statement: specialinvoke $r25.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2562!1 String)
(assert (= var2562!1 ""))
(assert true)
(define-const var2171 String (append/672562846 var2562!1 "Illegal initial capacity: ")) ; Statement: $r21 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal initial capacity: ") 
(declare-const var2562!2 String)
(assert (= var2562!2 (str.++ var2562!1 "Illegal initial capacity: ")))
(assert true)
(define-const var1845 String (append/-1001720160 var2171 var807)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2171!1 String)
(assert (str.prefixof var2171 var2171!1))
(assert true)
(define-const var389 String (toString/-2075883882 var1845)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2746 var389)) ; Statement: specialinvoke $r26.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r23) 

(declare-const var2746!1 var3627)
(declare-const var389!1 String)
 ; Statement: throw $r26 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2460-to-var1084=([org.apache.dubbo.common.utils.LFUCache], java.lang.Object), curSize/-1034741791=([org.apache.dubbo.common.utils.LFUCache], int), var1787-init=([], java.util.concurrent.locks.ReentrantLock), <init>/-377021476=([java.util.concurrent.locks.ReentrantLock], void), lock/-1034741791=([org.apache.dubbo.common.utils.LFUCache], java.util.concurrent.locks.ReentrantLock), var3627-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2460=org.apache.dubbo.common.utils.LFUCache, var1152=r0, var807=i0, var1753=f0, var1084=java.lang.Object, var1787=java.util.concurrent.locks.ReentrantLock, var2599=$r24, var3627=java.lang.IllegalArgumentException, var2746=$r26, var2562=$r25, var2171=$r21, var1845=$r22, var389=$r23}
; {org.apache.dubbo.common.utils.LFUCache=var2460, r0=var1152, i0=var807, f0=var1753, java.lang.Object=var1084, java.util.concurrent.locks.ReentrantLock=var1787, $r24=var2599, java.lang.IllegalArgumentException=var3627, $r26=var2746, $r25=var2562, $r21=var2171, $r22=var1845, $r23=var389}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.LFUCache;	i0 := @parameter0: int;	f0 := @parameter1: float;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.common.utils.LFUCache: int curSize> = 0;	$r24 = new java.util.concurrent.locks.ReentrantLock;	specialinvoke $r24.<java.util.concurrent.locks.ReentrantLock: void <init>()>();	r0.<org.apache.dubbo.common.utils.LFUCache: java.util.concurrent.locks.ReentrantLock lock> = $r24;	if i0 > 0 goto $b1 = f0 cmpg 1.0F;	$r26 = new java.lang.IllegalArgumentException;	$r25 = new java.lang.StringBuilder;	specialinvoke $r25.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal initial capacity: ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r26.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r23);	throw $r26
;block_num 2