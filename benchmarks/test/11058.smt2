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

(declare-sort var2037 0)
(declare-sort var256 0)
(declare-sort var2724 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getGroup/1342955253 (var2037) String)
(declare-fun var2724_isEmpty/-813097145 (String) Bool)
(declare-const null-var2037 var2037)
(declare-const null-String String)
(declare-const var2489 var2037) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2489 null-var2037)))
(declare-const var1886 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1886 null-String)))
(assert true)
(define-const var816 String (getGroup/1342955253 var2489)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var3198 Bool (var2724_isEmpty/-813097145 var816)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (not (= (ite var3198 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var395 String var1886) ; Statement: $r3 = r2 
 ; Statement: goto [?= return $r3] 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), var2724_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2037=org.apache.dubbo.common.URL, var2489=r0, var1886=r2, var256=null_type, var816=r1, var2724=org.apache.dubbo.common.utils.StringUtils, var3198=$z0, var395=$r3}
; {org.apache.dubbo.common.URL=var2037, r0=var2489, r2=var1886, null_type=var256, r1=var816, org.apache.dubbo.common.utils.StringUtils=var2724, $z0=var3198, $r3=var395}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r2;	goto [?= return $r3];	return $r3
;block_num 3