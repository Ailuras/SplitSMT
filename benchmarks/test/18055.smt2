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

(declare-sort var2493 0)
(declare-sort var2406 0)
(declare-sort var3069 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3069_isEmpty/-813097145 (String) Bool)
(declare-fun header/1021748984 (var2493 String String) var2493)
(declare-const null-var2493 var2493)
(declare-const null-String String)
(declare-const var2080 var2493) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder 
(assert (not (= var2080 null-var2493)))
(declare-const var3814 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3814 null-String)))
(declare-const var2069 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2069 null-String)))
(define-const var1438 Bool (var3069_isEmpty/-813097145 var2069)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r2, r0) 
(assert (= (ite var1438 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1427 var2493 (header/1021748984 var2080 var3814 var2069)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r2, r0) 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {var3069_isEmpty/-813097145=([java.lang.String], boolean), header/1021748984=([org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder, java.lang.String, java.lang.String], org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder)}
; {var2493=org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder, var2080=r1, var3814=r2, var2406=null_type, var2069=r0, var3069=org.apache.dubbo.common.utils.StringUtils, var1438=$z0, var1427=$r3}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder=var2493, r1=var2080, r2=var3814, null_type=var2406, r0=var2069, org.apache.dubbo.common.utils.StringUtils=var3069, $z0=var1438, $r3=var1427}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r2, r0);	$r3 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r2, r0);	return $r3
;block_num 3