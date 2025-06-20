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

(declare-sort var1244 0)
(declare-sort var2834 0)
(declare-sort var1933 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getGroup/1342955253 (var1244) String)
(declare-fun var1933_isEmpty/-813097145 (String) Bool)
(declare-const null-var1244 var1244)
(declare-const null-String String)
(declare-const var2237 var1244) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2237 null-var1244)))
(declare-const var450 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var450 null-String)))
(assert true)
(define-const var2544 String (getGroup/1342955253 var2237)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var1874 Bool (var1933_isEmpty/-813097145 var2544)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (= (ite var1874 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3885 String var2544) ; Statement: $r3 = r1 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), var1933_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1244=org.apache.dubbo.common.URL, var2237=r0, var450=r2, var2834=null_type, var2544=r1, var1933=org.apache.dubbo.common.utils.StringUtils, var1874=$z0, var3885=$r3}
; {org.apache.dubbo.common.URL=var1244, r0=var2237, r2=var450, null_type=var2834, r1=var2544, org.apache.dubbo.common.utils.StringUtils=var1933, $z0=var1874, $r3=var3885}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r1;	return $r3
;block_num 3