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

(declare-sort var2979 0)
(declare-sort var1807 0)
(declare-sort var2696 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var2979 String String) String)
(declare-fun var2696_isEmpty/-813097145 (String) Bool)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-const null-var2979 var2979)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2873 var2979) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2873 null-var2979)))
(declare-const var2638 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2638 null-String)))
(declare-const var277 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var277 null-String)))
(declare-const var2116 Int) ; Statement: c0 := @parameter2: char 
(assert (not (= var2116 null-Int)))
(assert true)
(define-const var1256 String (getMethodParameter/2015795402 var2873 var2638 var277)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3371 Bool (var2696_isEmpty/-813097145 var1256)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0) 
(assert (= (ite var3371 1 0) 0)) ; Cond: $z0 == 0 
(assert (and true (and (> (str.len var1256) 0) (<= 0 0))))
(define-const var938 Int (charAt/698050440 var1256 0)) ; Statement: $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0) 
(assert true) ; Non Conditional
 ; Statement: return $c1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2696_isEmpty/-813097145=([java.lang.String], boolean), charAt/698050440=([java.lang.String, int], char)}
; {var2979=org.apache.dubbo.common.URL, var2873=r0, var2638=r1, var1807=null_type, var277=r2, var2116=c0, var1256=r3, var2696=org.apache.dubbo.common.utils.StringUtils, var3371=$z0, var938=$c1}
; {org.apache.dubbo.common.URL=var2979, r0=var2873, r1=var2638, null_type=var1807, r2=var277, c0=var2116, r3=var1256, org.apache.dubbo.common.utils.StringUtils=var2696, $z0=var3371, $c1=var938}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.String: char charAt(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	c0 := @parameter2: char;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0);	$c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0);	return $c1
;block_num 3