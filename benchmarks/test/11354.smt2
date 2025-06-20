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

(declare-sort var229 0)
(declare-sort var131 0)
(declare-sort var3928 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSide/-520240817 (var229) String)
(declare-fun var3928_isEmpty/-813097145 (String) Bool)
(declare-const null-var229 var229)
(declare-const null-String String)
(declare-const var230 var229) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var230 null-var229)))
(declare-const var393 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var393 null-String)))
(assert true)
(define-const var773 String (getSide/-520240817 var230)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(define-const var249 Bool (var3928_isEmpty/-813097145 var773)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (not (= (ite var249 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2279 String var393) ; Statement: $r3 = r2 
 ; Statement: goto [?= return $r3] 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), var3928_isEmpty/-813097145=([java.lang.String], boolean)}
; {var229=org.apache.dubbo.common.URL, var230=r0, var393=r2, var131=null_type, var773=r1, var3928=org.apache.dubbo.common.utils.StringUtils, var249=$z0, var2279=$r3}
; {org.apache.dubbo.common.URL=var229, r0=var230, r2=var393, null_type=var131, r1=var773, org.apache.dubbo.common.utils.StringUtils=var3928, $z0=var249, $r3=var2279}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r2;	goto [?= return $r3];	return $r3
;block_num 3