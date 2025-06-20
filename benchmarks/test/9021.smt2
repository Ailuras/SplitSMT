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

(declare-sort var412 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun buildParameters/-2115216906 (var412 String Bool (Array Int String)) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var412 var412)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var217 var412) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var217 null-var412)))
(declare-const var3816 (Array Int String)) ; Statement: r2 := @parameter0: java.lang.String[] 
(assert (not (= var3816 null-__Array__Int__String__)))
(define-const var3624 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3624)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3624!1 String)
(assert (= var3624!1 ""))
(assert true)
;(assert (buildParameters/-2115216906 var217 var3624!1 (ite (= 1 0) true false) var3816)) ; Statement: virtualinvoke r1.<org.apache.dubbo.common.URL: void buildParameters(java.lang.StringBuilder,boolean,java.lang.String[])>($r0, 0, r2) 

(declare-const var217!1 var412)
(declare-const var3624!2 String)
(declare-const var1195 Int)
(declare-const var3816!1 (Array Int String))
(assert true)
(define-const var3852 String (toString/-2075883882 var3624!2)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), buildParameters/-2115216906=([org.apache.dubbo.common.URL, java.lang.StringBuilder, boolean, java.lang.String[]], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var412=org.apache.dubbo.common.URL, var217=r1, var3816=r2, var3624=$r0, var1195=0, var3852=$r3}
; {org.apache.dubbo.common.URL=var412, r1=var217, r2=var3816, $r0=var3624, 0=var1195, $r3=var3852}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	virtualinvoke r1.<org.apache.dubbo.common.URL: void buildParameters(java.lang.StringBuilder,boolean,java.lang.String[])>($r0, 0, r2);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 1