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

(declare-sort var2049 0)
(declare-sort var2776 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getAndIncrement/-721914959 (var2776) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1889012253 (var2049 String Bool) void)
(declare-const null-var2049 var2049)
(declare-const var2049-POOL_SEQ var2776)
(declare-const var236 var2049) ; Statement: r0 := @this: org.apache.dubbo.common.utils.NamedThreadFactory 
(assert (not (= var236 null-var2049)))
(define-const var1720 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1720)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1720!1 String)
(assert (= var1720!1 ""))
(assert true)
(define-const var1563 String (append/672562846 var1720!1 "pool-")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pool-") 
(declare-const var1720!2 String)
(assert (= var1720!2 (str.++ var1720!1 "pool-")))
(define-const var2568 var2776 var2049-POOL_SEQ) ; Statement: $r2 = <org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger POOL_SEQ> 
(assert true)
(define-const var536 Int (getAndIncrement/-721914959 var2568)) ; Statement: $i0 = virtualinvoke $r2.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>() 
(assert true)
(define-const var1713 String (append/-1001720160 var1563 var536)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1563!1 String)
(assert (str.prefixof var1563 var1563!1))
(assert true)
(define-const var3845 String (toString/-2075883882 var1713)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1889012253 var236 var3845 (ite (= 1 0) true false))) ; Statement: specialinvoke r0.<org.apache.dubbo.common.utils.NamedThreadFactory: void <init>(java.lang.String,boolean)>($r5, 0) 

(declare-const var236!1 var2049)
(declare-const var3845!1 String)
(declare-const var2102 Int)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getAndIncrement/-721914959=([java.util.concurrent.atomic.AtomicInteger], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1889012253=([org.apache.dubbo.common.utils.NamedThreadFactory, java.lang.String, boolean], void)}
; {var2049=org.apache.dubbo.common.utils.NamedThreadFactory, var236=r0, var1720=$r1, var1563=$r3, var2776=java.util.concurrent.atomic.AtomicInteger, var2568=$r2, var536=$i0, var1713=$r4, var3845=$r5, var2102=0}
; {org.apache.dubbo.common.utils.NamedThreadFactory=var2049, r0=var236, $r1=var1720, $r3=var1563, java.util.concurrent.atomic.AtomicInteger=var2776, $r2=var2568, $i0=var536, $r4=var1713, $r5=var3845, 0=var2102}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.NamedThreadFactory;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("pool-");	$r2 = <org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger POOL_SEQ>;	$i0 = virtualinvoke $r2.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<org.apache.dubbo.common.utils.NamedThreadFactory: void <init>(java.lang.String,boolean)>($r5, 0);	return
;block_num 1