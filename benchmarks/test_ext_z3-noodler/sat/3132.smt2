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

(declare-sort var2052 0)
(declare-sort var956 0)
(declare-sort var3268 0)
(declare-sort var981 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var956_getParameter/-1739295734 (var2052 String String) String)
(declare-fun var981_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2052 var2052)
(declare-const null-String String)
(declare-const var3730 var2052) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3730 null-var2052)))
(define-const var91 String (var956_getParameter/-1739295734 var3730 "dubbo.config-center.group" null-String)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.group", null) 
(define-const var2607 Bool (var981_isBlank/-523695098 (cast-from-String-to-String var91))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = r1 
(assert (not (= (ite var2607 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var361 String (var956_getParameter/-1739295734 var3730 "group" "dubbo")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "group", "dubbo") 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var956_getParameter/-1739295734=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var981_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2052=org.apache.dubbo.common.URL, var3730=r0, var956=org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration, var3268=null_type, var91=r1, var981=org.apache.dubbo.common.utils.StringUtils, var2607=$z0, var361=$r2}
; {org.apache.dubbo.common.URL=var2052, r0=var3730, org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration=var956, null_type=var3268, r1=var91, org.apache.dubbo.common.utils.StringUtils=var981, $z0=var2607, $r2=var361}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = staticinvoke <org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.group", null);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r2 = r1;	$r2 = staticinvoke <org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "group", "dubbo");	goto [?= return $r2];	return $r2
;block_num 3