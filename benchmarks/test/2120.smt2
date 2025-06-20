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

(declare-sort var1767 0)
(declare-sort var684 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun port/1139202793 (var1767) Int)
(declare-fun host/1139202793 (var1767) String)
(declare-const null-var1767 var1767)
(declare-const null-String String)
(declare-const var43 var1767) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var43 null-var1767)))
(declare-const var293 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var293 null-String)))
(assert true)
(define-const var1125 Int (lastIndexOf/-1292097097 var293 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58) 
(define-const var530 Int (port/1139202793 var43)) ; Statement: i2 = r1.<org.apache.dubbo.common.URLBuilder: int port> 
 ; Statement: if i0 < 0 goto r3 = r0 
(assert (< var1125 0)) ; Cond: i0 < 0 
(define-const var2160 String var293) ; Statement: r3 = r0 
(assert true) ; Non Conditional
(declare-const var43!1 var1767)
(assert (not (= var43!1 null-var1767)))
(assert (= (host/1139202793 var43!1) var2160)) ; Statement: r1.<org.apache.dubbo.common.URLBuilder: java.lang.String host> = r3 
(declare-const var43!2 var1767)
(assert (not (= var43!2 null-var1767)))
(assert (= (port/1139202793 var43!2) var530)) ; Statement: r1.<org.apache.dubbo.common.URLBuilder: int port> = i2 
 ; Statement: return r1 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), port/1139202793=([org.apache.dubbo.common.URLBuilder], int), host/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String)}
; {var1767=org.apache.dubbo.common.URLBuilder, var43=r1, var293=r0, var684=null_type, var1125=i0, var530=i2, var2160=r3}
; {org.apache.dubbo.common.URLBuilder=var1767, r1=var43, r0=var293, null_type=var684, i0=var1125, i2=var530, r3=var2160}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58);	i2 = r1.<org.apache.dubbo.common.URLBuilder: int port>;	if i0 < 0 goto r3 = r0;	r3 = r0;	r1.<org.apache.dubbo.common.URLBuilder: java.lang.String host> = r3;	r1.<org.apache.dubbo.common.URLBuilder: int port> = i2;	return r1
;block_num 3