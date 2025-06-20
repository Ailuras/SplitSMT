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

(declare-sort var3791 0)
(declare-sort var942 0)
(declare-sort var1467 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplication/-536601276 (var3791) String)
(declare-fun var1467_isEmpty/-813097145 (String) Bool)
(declare-const null-var3791 var3791)
(declare-const null-String String)
(declare-const var1174 var3791) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1174 null-var3791)))
(declare-const var1948 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1948 null-String)))
(assert true)
(define-const var706 String (getApplication/-536601276 var1174)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
(define-const var3646 Bool (var1467_isEmpty/-813097145 var706)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (not (= (ite var3646 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3974 String var1948) ; Statement: $r3 = r2 
 ; Statement: goto [?= return $r3] 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String), var1467_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3791=org.apache.dubbo.common.URL, var1174=r0, var1948=r2, var942=null_type, var706=r1, var1467=org.apache.dubbo.common.utils.StringUtils, var3646=$z0, var3974=$r3}
; {org.apache.dubbo.common.URL=var3791, r0=var1174, r2=var1948, null_type=var942, r1=var706, org.apache.dubbo.common.utils.StringUtils=var1467, $z0=var3646, $r3=var3974}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r2;	goto [?= return $r3];	return $r3
;block_num 3