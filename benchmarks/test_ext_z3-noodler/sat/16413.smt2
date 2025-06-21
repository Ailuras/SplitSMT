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

(declare-sort var3491 0)
(declare-sort var1253 0)
(declare-sort var2902 0)
(declare-sort var3995 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1253 String) String)
(declare-fun var3995_isEmpty/-813097145 (String) Bool)
(declare-const null-var3491 var3491)
(declare-const null-var1253 var1253)
(declare-const null-String String)
(declare-const var2192 var3491) ; Statement: r6 := @this: org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter 
(assert (not (= var2192 null-var3491)))
(declare-const var651 var1253) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var651 null-var1253)))
(declare-const var2920 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var2920 null-String)))
(assert true)
(define-const var1525 String (getParameter/-1307325648 var651 "telnet")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("telnet") 
(define-const var1590 Bool (var3995_isEmpty/-813097145 var1525)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (not (= (ite var1590 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3995_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3491=org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter, var2192=r6, var1253=org.apache.dubbo.common.URL, var651=r0, var2920=r5, var2902=null_type, var1525=r1, var3995=org.apache.dubbo.common.utils.StringUtils, var1590=$z0}
; {org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter=var3491, r6=var2192, org.apache.dubbo.common.URL=var1253, r0=var651, r5=var2920, null_type=var2902, r1=var1525, org.apache.dubbo.common.utils.StringUtils=var3995, $z0=var1590}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter;	r0 := @parameter0: org.apache.dubbo.common.URL;	r5 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("telnet");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	return 0
;block_num 2