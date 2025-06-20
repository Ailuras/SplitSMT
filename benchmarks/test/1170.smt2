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

(declare-sort var3252 0)
(declare-sort var1533 0)
(declare-sort var2552 0)
(declare-sort var3153 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1533-init () var1533)
(declare-fun var3153_parseQueryString/-1071871736 (String) var2552)
(declare-fun <init>/-1156261826 (var1533 var2552) void)
(declare-const null-String String)
(declare-const var1982 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1982 null-String)))
(define-const var2302 var1533 var1533-init) ; Statement: $r0 = new org.apache.dubbo.common.Parameters 
(define-const var1924 var2552 (var3153_parseQueryString/-1071871736 var1982)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r1) 
(assert true)
;(assert (<init>/-1156261826 var2302 var1924)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.Parameters: void <init>(java.util.Map)>($r2) 

(declare-const var2302!1 var1533)
(declare-const var1924!1 var2552)
 ; Statement: return $r0 
(check-sat)
; {var1533-init=([], org.apache.dubbo.common.Parameters), var3153_parseQueryString/-1071871736=([java.lang.String], java.util.Map), <init>/-1156261826=([org.apache.dubbo.common.Parameters, java.util.Map], void)}
; {var1982=r1, var3252=null_type, var1533=org.apache.dubbo.common.Parameters, var2302=$r0, var2552=java.util.Map, var3153=org.apache.dubbo.common.utils.StringUtils, var1924=$r2}
; {r1=var1982, null_type=var3252, org.apache.dubbo.common.Parameters=var1533, $r0=var2302, java.util.Map=var2552, org.apache.dubbo.common.utils.StringUtils=var3153, $r2=var1924}
;seq <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new org.apache.dubbo.common.Parameters;	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r1);	specialinvoke $r0.<org.apache.dubbo.common.Parameters: void <init>(java.util.Map)>($r2);	return $r0
;block_num 1