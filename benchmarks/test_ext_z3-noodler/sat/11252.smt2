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

(declare-sort var574 0)
(declare-sort var339 0)
(declare-sort var1601 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCategory/-1855000632 (var574) String)
(declare-fun var1601_isEmpty/-813097145 (String) Bool)
(declare-const null-var574 var574)
(declare-const null-String String)
(declare-const var1624 var574) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1624 null-var574)))
(declare-const var3 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3 null-String)))
(assert true)
(define-const var43 String (getCategory/-1855000632 var1624)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>() 
(define-const var1515 Bool (var1601_isEmpty/-813097145 var43)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto return r2 
(assert (= (ite var1515 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r2 
(check-sat)
; {getCategory/-1855000632=([org.apache.dubbo.common.URL], java.lang.String), var1601_isEmpty/-813097145=([java.lang.String], boolean)}
; {var574=org.apache.dubbo.common.URL, var1624=r0, var3=r1, var339=null_type, var43=r2, var1601=org.apache.dubbo.common.utils.StringUtils, var1515=$z0}
; {org.apache.dubbo.common.URL=var574, r0=var1624, r1=var3, null_type=var339, r2=var43, org.apache.dubbo.common.utils.StringUtils=var1601, $z0=var1515}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto return r2;	return r2
;block_num 2