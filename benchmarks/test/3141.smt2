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

(declare-sort var2948 0)
(declare-sort var1620 0)
(declare-sort var927 0)
(declare-sort var303 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1620_getParameter/-1739295734 (var2948 String String) String)
(declare-fun var303_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2948 var2948)
(declare-const null-String String)
(declare-const var1007 var2948) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1007 null-var2948)))
(define-const var1096 String (var1620_getParameter/-1739295734 var1007 "dubbo.config-center.group" null-String)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.group", null) 
(define-const var2155 Bool (var303_isBlank/-523695098 (cast-from-String-to-String var1096))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = r1 
(assert (= (ite var2155 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3169 String var1096) ; Statement: $r2 = r1 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1620_getParameter/-1739295734=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var303_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2948=org.apache.dubbo.common.URL, var1007=r0, var1620=org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration, var927=null_type, var1096=r1, var303=org.apache.dubbo.common.utils.StringUtils, var2155=$z0, var3169=$r2}
; {org.apache.dubbo.common.URL=var2948, r0=var1007, org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration=var1620, null_type=var927, r1=var1096, org.apache.dubbo.common.utils.StringUtils=var303, $z0=var2155, $r2=var3169}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = staticinvoke <org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.group", null);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r2 = r1;	$r2 = r1;	return $r2
;block_num 3