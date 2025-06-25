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

(declare-sort var1340 0)
(declare-sort var1466 0)
(declare-sort var1515 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1466_getSystemProperty/590859155 (String String) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1515_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1340 var1340)
(declare-const var2415 var1340) ; Statement: r5 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator 
(assert (not (= var2415 null-var1340)))
(define-const var1879 String (var1466_getSystemProperty/590859155 "dubbo.security.serialize.allowedClassList" "")) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.allowedClassList", "") 
(assert true)
(define-const var1301 String (trim/-847153721 var1879)) ; Statement: r1 = virtualinvoke $r0.<java.lang.String: java.lang.String trim()>() 
(define-const var1931 String (var1466_getSystemProperty/590859155 "dubbo.security.serialize.blockedClassList" "")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.blockedClassList", "") 
(assert true)
(define-const var2375 String (trim/-847153721 var1931)) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
(define-const var97 Bool (var1515_isNotEmpty/-1251449450 var1301)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
(assert (not (= (ite var97 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3323 String (trim/-847153721 var1301)) ; Statement: $r7 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
; split operation: var417 = var3323.split(",") ; Statement: r9 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3311 Int (get_split_length var3323 "," -1)) ; Statement: i0 = lengthof r9 
(define-const var3410 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
(assert (>= var3410 var3311)) ; Cond: i1 >= i0 
(define-const var1308 Bool (var1515_isNotEmpty/-1251449450 var2375)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var1308 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {var1466_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var1515_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1340=org.apache.dubbo.common.utils.SerializeSecurityConfigurator, var2415=r5, var1466=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var1879=$r0, var1301=r1, var1931=$r2, var2375=r3, var1515=org.apache.dubbo.common.utils.StringUtils, var97=$z0, var3323=$r7, var417=r9, var3311=i0, var3410=i1, var1308=$z1}
; {org.apache.dubbo.common.utils.SerializeSecurityConfigurator=var1340, r5=var2415, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var1466, $r0=var1879, r1=var1301, $r2=var1931, r3=var2375, org.apache.dubbo.common.utils.StringUtils=var1515, $z0=var97, $r7=var3323, r9=var417, i0=var3311, i1=var3410, $z1=var1308}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String trim()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 3,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator;	$r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.allowedClassList", "");	r1 = virtualinvoke $r0.<java.lang.String: java.lang.String trim()>();	$r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.security.serialize.blockedClassList", "");	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	$r7 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	r9 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r9;	i1 = 0;	if i1 >= i0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z1 == 0 goto return;	return
;block_num 5