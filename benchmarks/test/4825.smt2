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

(declare-sort var1019 0)
(declare-sort var1070 0)
(declare-sort var2707 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1019 String) String)
(declare-fun var2707_isEmpty/-813097145 (String) Bool)
(declare-const null-var1019 var1019)
(declare-const null-String String)
(declare-const var1364 var1019) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1364 null-var1019)))
(declare-const var3569 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3569 null-String)))
(declare-const var1895 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var1895 null-String)))
(assert true)
(define-const var3578 String (getParameter/-1307325648 var1364 var3569)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1832 Bool (var2707_isEmpty/-813097145 var3578)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = r2 
(assert (not (= (ite var1832 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2766 String var1895) ; Statement: $r4 = r3 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2707_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1019=org.apache.dubbo.common.URL, var1364=r0, var3569=r1, var1070=null_type, var1895=r3, var3578=r2, var2707=org.apache.dubbo.common.utils.StringUtils, var1832=$z0, var2766=$r4}
; {org.apache.dubbo.common.URL=var1019, r0=var1364, r1=var3569, null_type=var1070, r3=var1895, r2=var3578, org.apache.dubbo.common.utils.StringUtils=var2707, $z0=var1832, $r4=var2766}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = r2;	$r4 = r3;	goto [?= return $r4];	return $r4
;block_num 3