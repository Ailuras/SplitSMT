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

(declare-sort var1821 0)
(declare-sort var1699 0)
(declare-sort var1936 0)
(declare-sort var3280 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1699_notNull/751190363 (var1936 String) void)
(declare-fun cast-from-String-to-var1936 (String) var1936)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun var3280-init () var3280)
(declare-fun <init>/-1387535912 (var3280 String) void)
(declare-const null-String String)
(declare-const var2734 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2734 null-String)))
;(assert (var1699_notNull/751190363 (cast-from-String-to-var1936 var2734) "Resource location must not be null")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Resource location must not be null") 

(declare-const var2734!1 String)
(declare-const var3686 String)
(assert true)
(define-const var2379 Bool (startsWith/-1785782452 var2734!1 "classpath:")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("classpath:") 
 ; Statement: if $z0 == 0 goto $r1 = new java.net.URL 
(assert (= (ite var2379 1 0) 0)) ; Cond: $z0 == 0 
(define-const var31 var3280 var3280-init) ; Statement: $r1 = new java.net.URL 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/-1387535912 var31 var2734!1)) ; Statement: specialinvoke $r1.<java.net.URL: void <init>(java.lang.String)>(r0) 

(declare-const var31!1 var3280)
(declare-const var2734!2 String)
(assert true) ; Non Conditional
 ; Statement: return $r1 
(check-sat)
; {var1699_notNull/751190363=([java.lang.Object, java.lang.String], void), cast-from-String-to-var1936=([java.lang.String], java.lang.Object), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), var3280-init=([], java.net.URL), <init>/-1387535912=([java.net.URL, java.lang.String], void)}
; {var2734=r0, var1821=null_type, var1699=org.apache.dubbo.common.utils.Assert, var1936=java.lang.Object, var3686="Resource location must not be null", var2379=$z0, var3280=java.net.URL, var31=$r1}
; {r0=var2734, null_type=var1821, org.apache.dubbo.common.utils.Assert=var1699, java.lang.Object=var1936, "Resource location must not be null"=var3686, $z0=var2379, java.net.URL=var3280, $r1=var31}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Resource location must not be null");	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("classpath:");	if $z0 == 0 goto $r1 = new java.net.URL;	$r1 = new java.net.URL;	specialinvoke $r1.<java.net.URL: void <init>(java.lang.String)>(r0);	return $r1
;block_num 4