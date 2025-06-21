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

(declare-sort var3022 0)
(declare-sort var3543 0)
(declare-sort var576 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var576_isEmpty/-813097145 (String) Bool)
(declare-const null-var3022 var3022)
(declare-const null-String String)
(declare-const var1776 var3022) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder 
(assert (not (= var1776 null-var3022)))
(declare-const var2125 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2125 null-String)))
(declare-const var2672 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2672 null-String)))
(define-const var303 Bool (var576_isEmpty/-813097145 var2672)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r2, r0) 
(assert (not (= (ite var303 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3898 var3022 var1776) ; Statement: $r3 = r1 
 ; Statement: goto [?= return $r3] 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {var576_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3022=org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder, var1776=r1, var2125=r2, var3543=null_type, var2672=r0, var576=org.apache.dubbo.common.utils.StringUtils, var303=$z0, var3898=$r3}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder=var3022, r1=var1776, r2=var2125, null_type=var3543, r0=var2672, org.apache.dubbo.common.utils.StringUtils=var576, $z0=var303, $r3=var3898}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r2, r0);	$r3 = r1;	goto [?= return $r3];	return $r3
;block_num 3