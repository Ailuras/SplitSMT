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

(declare-sort var2807 0)
(declare-sort var2943 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCategory/-1855000632 (var2807) String)
(declare-fun var2943_isEmpty/-813097145 (String) Bool)
(declare-const null-var2807 var2807)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1302 var2807) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1302 null-var2807)))
(declare-const var1423 (Array Int String)) ; Statement: r3 := @parameter0: java.lang.String[] 
(assert (not (= var1423 null-__Array__Int__String__)))
(assert true)
(define-const var3837 String (getCategory/-1855000632 var1302)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>() 
(define-const var1107 Bool (var2943_isEmpty/-813097145 var3837)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (not (= (ite var1107 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1511 (Array Int String) var1423) ; Statement: $r4 = r3 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {getCategory/-1855000632=([org.apache.dubbo.common.URL], java.lang.String), var2943_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2807=org.apache.dubbo.common.URL, var1302=r0, var1423=r3, var3837=r1, var2943=org.apache.dubbo.common.utils.StringUtils, var1107=$z0, var1511=$r4}
; {org.apache.dubbo.common.URL=var2807, r0=var1302, r3=var1423, r1=var3837, org.apache.dubbo.common.utils.StringUtils=var2943, $z0=var1107, $r4=var1511}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r3 := @parameter0: java.lang.String[];	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r4 = r3;	goto [?= return $r4];	return $r4
;block_num 3