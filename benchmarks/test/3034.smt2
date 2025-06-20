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

(declare-sort var3343 0)
(declare-sort var1989 0)
(declare-sort var449 0)
(declare-sort var1741 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var449_isEmpty/-813097145 (String) Bool)
(declare-fun var449_parseQueryString/-1071871736 (String) var1741)
(declare-fun addParameters/1450696488 (var3343 var1741) var3343)
(declare-const null-var3343 var3343)
(declare-const null-String String)
(declare-const var1199 var3343) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var1199 null-var3343)))
(declare-const var3792 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3792 null-String)))
(define-const var49 Bool (var449_isEmpty/-813097145 var3792)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0) 
(assert (= (ite var49 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2073 var1741 (var449_parseQueryString/-1071871736 var3792)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0) 
(assert true)
(define-const var2638 var3343 (addParameters/1450696488 var1199 var2073)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameters(java.util.Map)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {var449_isEmpty/-813097145=([java.lang.String], boolean), var449_parseQueryString/-1071871736=([java.lang.String], java.util.Map), addParameters/1450696488=([org.apache.dubbo.common.URLBuilder, java.util.Map], org.apache.dubbo.common.URLBuilder)}
; {var3343=org.apache.dubbo.common.URLBuilder, var1199=r1, var3792=r0, var1989=null_type, var449=org.apache.dubbo.common.utils.StringUtils, var49=$z0, var1741=java.util.Map, var2073=$r2, var2638=$r3}
; {org.apache.dubbo.common.URLBuilder=var3343, r1=var1199, r0=var3792, null_type=var1989, org.apache.dubbo.common.utils.StringUtils=var449, $z0=var49, java.util.Map=var1741, $r2=var2073, $r3=var2638}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0);	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameters(java.util.Map)>($r2);	return $r3
;block_num 2