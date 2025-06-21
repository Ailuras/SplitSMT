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

(declare-sort var2901 0)
(declare-sort var2073 0)
(declare-sort var2928 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2073_getSystemProperty/590859155 (String String) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var2928_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2901 var2901)
(declare-const var3523 var2901) ; Statement: r5 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator 
(assert (not (= var3523 null-var2901)))
(define-const var3610 String (var2073_getSystemProperty/590859155 "dubbo.security.serialize.allowedClassList" "")) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.allowedClassList", "") 
(assert true)
(define-const var1091 String (trim/-847153721 var3610)) ; Statement: r1 = virtualinvoke $r0.<java.lang.String: java.lang.String trim()>() 
(define-const var370 String (var2073_getSystemProperty/590859155 "dubbo.security.serialize.blockedClassList" "")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.blockedClassList", "") 
(assert true)
(define-const var120 String (trim/-847153721 var370)) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
(define-const var1518 Bool (var2928_isNotEmpty/-1251449450 var1091)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
(assert (= (ite var1518 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2989 Bool (var2928_isNotEmpty/-1251449450 var120)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var2989 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {var2073_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var2928_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2901=org.apache.dubbo.common.utils.SerializeSecurityConfigurator, var3523=r5, var2073=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3610=$r0, var1091=r1, var370=$r2, var120=r3, var2928=org.apache.dubbo.common.utils.StringUtils, var1518=$z0, var2989=$z1}
; {org.apache.dubbo.common.utils.SerializeSecurityConfigurator=var2901, r5=var3523, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2073, $r0=var3610, r1=var1091, $r2=var370, r3=var120, org.apache.dubbo.common.utils.StringUtils=var2928, $z0=var1518, $z1=var2989}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String trim()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 2,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2}
;stmts r5 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator;	$r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.allowedClassList", "");	r1 = virtualinvoke $r0.<java.lang.String: java.lang.String trim()>();	$r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.blockedClassList", "");	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z1 == 0 goto return;	return
;block_num 3