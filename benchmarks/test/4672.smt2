(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1666 0)
(declare-sort var3532 0)
(declare-sort var670 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3532_getSystemProperty/590859155 (String String) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var670_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1666 var1666)
(declare-const var1741 var1666) ; Statement: r5 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator 
(assert (not (= var1741 null-var1666)))
(define-const var3928 String (var3532_getSystemProperty/590859155 "dubbo.security.serialize.allowedClassList" "")) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.allowedClassList", "") 
(assert true)
(define-const var2998 String (trim/-847153721 var3928)) ; Statement: r1 = virtualinvoke $r0.<java.lang.String: java.lang.String trim()>() 
(define-const var1403 String (var3532_getSystemProperty/590859155 "dubbo.security.serialize.blockedClassList" "")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.blockedClassList", "") 
(assert true)
(define-const var277 String (trim/-847153721 var1403)) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
(define-const var259 Bool (var670_isNotEmpty/-1251449450 var2998)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
(assert (= (ite var259 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1643 Bool (var670_isNotEmpty/-1251449450 var277)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z1 == 0 goto return 
(assert (not (= (ite var1643 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var1992 String (trim/-847153721 var277)) ; Statement: $r4 = virtualinvoke r3.<java.lang.String: java.lang.String trim()>() 
; split operation: var1482 = var1992.split(",") ; Statement: r12 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3522 Int (get_split_length var1992 "," -1)) ; Statement: i2 = lengthof r12 
(define-const var3607 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto return 
(assert (>= var3607 var3522)) ; Cond: i3 >= i2 
 ; Statement: return 
(check-sat)
; {var3532_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var670_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1666=org.apache.dubbo.common.utils.SerializeSecurityConfigurator, var1741=r5, var3532=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3928=$r0, var2998=r1, var1403=$r2, var277=r3, var670=org.apache.dubbo.common.utils.StringUtils, var259=$z0, var1643=$z1, var1992=$r4, var1482=r12, var3522=i2, var3607=i3}
; {org.apache.dubbo.common.utils.SerializeSecurityConfigurator=var1666, r5=var1741, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3532, $r0=var3928, r1=var2998, $r2=var1403, r3=var277, org.apache.dubbo.common.utils.StringUtils=var670, $z0=var259, $z1=var1643, $r4=var1992, r12=var1482, i2=var3522, i3=var3607}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String trim()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 3,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator;	$r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.allowedClassList", "");	r1 = virtualinvoke $r0.<java.lang.String: java.lang.String trim()>();	$r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.blockedClassList", "");	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z1 == 0 goto return;	$r4 = virtualinvoke r3.<java.lang.String: java.lang.String trim()>();	r12 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i2 = lengthof r12;	i3 = 0;	if i3 >= i2 goto return;	return
;block_num 5