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

(declare-sort var1557 0)
(declare-sort var3588 0)
(declare-sort var1776 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var1776) String)
(declare-fun header/1021748984 (var1557 String String) var1557)
(declare-const null-var1557 var1557)
(declare-const null-String String)
(declare-const null-var1776 var1776)
(declare-const var2644 var1557) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder 
(assert (not (= var2644 null-var1557)))
(declare-const var3043 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3043 null-String)))
(declare-const var1238 var1776) ; Statement: r2 := @parameter1: java.lang.Object 
(assert (not (= var1238 null-var1776)))
(define-const var2418 String (String_valueOf/-333372740 var1238)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r2) 
(assert true)
(define-const var430 var1557 (header/1021748984 var2644 var3043 var2418)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r1, $r3) 
 ; Statement: return $r4 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), header/1021748984=([org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder, java.lang.String, java.lang.String], org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder)}
; {var1557=org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder, var2644=r0, var3043=r1, var3588=null_type, var1776=java.lang.Object, var1238=r2, var2418=$r3, var430=$r4}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder=var1557, r0=var2644, r1=var3043, null_type=var3588, java.lang.Object=var1776, r2=var1238, $r3=var2418, $r4=var430}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Object;	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r2);	$r4 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder: org.apache.dubbo.remoting.http12.message.DefaultHttpResult$Builder header(java.lang.String,java.lang.String)>(r1, $r3);	return $r4
;block_num 1