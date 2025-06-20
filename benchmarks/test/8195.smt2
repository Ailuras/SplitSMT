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

(declare-sort var506 0)
(declare-sort var3733 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun incrementAndGet/613115697 (var506) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3733_getCache/-491744304 (String) var3733)
(declare-const var3733-nameIndex var506)
(define-const var1985 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1985)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1985!1 String)
(assert (= var1985!1 ""))
(assert true)
(define-const var3692 String (append/672562846 var1985!1 "_DEFAULT_#")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_DEFAULT_#") 
(declare-const var1985!2 String)
(assert (= var1985!2 (str.++ var1985!1 "_DEFAULT_#")))
(define-const var1375 var506 var3733-nameIndex) ; Statement: $r1 = <org.apache.dubbo.config.utils.SimpleReferenceCache: java.util.concurrent.atomic.AtomicInteger nameIndex> 
(assert true)
(define-const var423 Int (incrementAndGet/613115697 var1375)) ; Statement: $i0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: int incrementAndGet()>() 
(assert true)
(define-const var2541 String (append/-1001720160 var3692 var423)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3692!1 String)
(assert (str.prefixof var3692 var3692!1))
(assert true)
(define-const var610 String (toString/-2075883882 var2541)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2661 var3733 (var3733_getCache/-491744304 var610)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.config.utils.SimpleReferenceCache: org.apache.dubbo.config.utils.SimpleReferenceCache getCache(java.lang.String)>($r4) 
 ; Statement: return $r5 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), incrementAndGet/613115697=([java.util.concurrent.atomic.AtomicInteger], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3733_getCache/-491744304=([java.lang.String], org.apache.dubbo.config.utils.SimpleReferenceCache)}
; {var1985=$r0, var3692=$r2, var506=java.util.concurrent.atomic.AtomicInteger, var3733=org.apache.dubbo.config.utils.SimpleReferenceCache, var1375=$r1, var423=$i0, var2541=$r3, var610=$r4, var2661=$r5}
; {$r0=var1985, $r2=var3692, java.util.concurrent.atomic.AtomicInteger=var506, org.apache.dubbo.config.utils.SimpleReferenceCache=var3733, $r1=var1375, $i0=var423, $r3=var2541, $r4=var610, $r5=var2661}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts $r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_DEFAULT_#");	$r1 = <org.apache.dubbo.config.utils.SimpleReferenceCache: java.util.concurrent.atomic.AtomicInteger nameIndex>;	$i0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: int incrementAndGet()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = staticinvoke <org.apache.dubbo.config.utils.SimpleReferenceCache: org.apache.dubbo.config.utils.SimpleReferenceCache getCache(java.lang.String)>($r4);	return $r5
;block_num 1