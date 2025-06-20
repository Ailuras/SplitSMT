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

(declare-sort var303 0)
(declare-sort var2645 0)
(declare-sort var1102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/506106603 (var2645 String String) String)
(declare-fun var1102_isEmpty/-813097145 (String) Bool)
(declare-const null-var303 var303)
(declare-const null-var2645 var2645)
(declare-const var2018 var303) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.AbstractProtocol 
(assert (not (= var2018 null-var303)))
(declare-const var1537 var2645) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1537 null-var2645)))
(assert true)
(define-const var53 String (getParameter/506106603 var1537 "optimizer" "")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("optimizer", "") 
(define-const var1295 Bool (var1102_isEmpty/-813097145 var53)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1295 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1102_isEmpty/-813097145=([java.lang.String], boolean)}
; {var303=org.apache.dubbo.rpc.protocol.AbstractProtocol, var2018=r2, var2645=org.apache.dubbo.common.URL, var1537=r0, var53=r1, var1102=org.apache.dubbo.common.utils.StringUtils, var1295=$z0}
; {org.apache.dubbo.rpc.protocol.AbstractProtocol=var303, r2=var2018, org.apache.dubbo.common.URL=var2645, r0=var1537, r1=var53, org.apache.dubbo.common.utils.StringUtils=var1102, $z0=var1295}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.AbstractProtocol;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("optimizer", "");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 != 0 goto return;	return
;block_num 2