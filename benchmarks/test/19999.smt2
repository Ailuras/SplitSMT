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

(declare-sort var2424 0)
(declare-sort var3608 0)
(declare-sort var3890 0)
(declare-sort var3786 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3890 String) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var2424 var2424)
(declare-const null-var3608 var3608)
(declare-const null-var3890 var3890)
(declare-const null-String String)
(declare-const var1422 var2424) ; Statement: r14 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1 
(assert (not (= var1422 null-var2424)))
(declare-const var2142 var3608) ; Statement: r15 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2142 null-var3608)))
(declare-const var1212 var3890) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1212 null-var3890)))
(declare-const var2552 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var2552 null-String)))
(assert true)
(define-const var3338 String (getParameter/-1307325648 var1212 var2552)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
 ; Statement: if r2 == null goto return null 
(assert (not (= var3338 null-String))) ; Negate: Cond: r2 == null  
(assert true)
(define-const var2793 Int (length/-134980193 var3338)) ; Statement: $i0 = virtualinvoke r2.<java.lang.String: int length()>() 
 ; Statement: if $i0 != 0 goto $r3 = new org.apache.dubbo.rpc.RpcInvocation 
(assert (not (not (= var2793 0)))) ; Negate: Cond: $i0 != 0  
 ; Statement: return null 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var2424=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1, var1422=r14, var3608=org.apache.dubbo.remoting.Channel, var2142=r15, var3890=org.apache.dubbo.common.URL, var1212=r0, var2552=r1, var3786=null_type, var3338=r2, var2793=$i0}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1=var2424, r14=var1422, org.apache.dubbo.remoting.Channel=var3608, r15=var2142, org.apache.dubbo.common.URL=var3890, r0=var1212, r1=var2552, null_type=var3786, r2=var3338, $i0=var2793}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r14 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1;	r15 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.common.URL;	r1 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	if r2 == null goto return null;	$i0 = virtualinvoke r2.<java.lang.String: int length()>();	if $i0 != 0 goto $r3 = new org.apache.dubbo.rpc.RpcInvocation;	return null
;block_num 3