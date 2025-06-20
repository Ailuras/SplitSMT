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

(declare-sort var3909 0)
(declare-sort var3083 0)
(declare-sort var2950 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun username/1139202793 (var3909) String)
(declare-fun var3083_isEmpty/-813097145 (String) Bool)
(declare-fun password/1139202793 (var3909) String)
(declare-fun var3083_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var2950-init () var2950)
(declare-fun <init>/875830710 (var2950 String) void)
(declare-const null-var3909 var3909)
(declare-const var849 var3909) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var849 null-var3909)))
(define-const var2911 String (username/1139202793 var849)) ; Statement: $r1 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String username> 
(define-const var3767 Bool (var3083_isEmpty/-813097145 var2911)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $i0 = r0.<org.apache.dubbo.common.URLBuilder: int port> 
(assert (not (= (ite var3767 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2256 String (password/1139202793 var849)) ; Statement: $r8 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String password> 
(define-const var2453 Bool (var3083_isNotEmpty/-1251449450 var2256)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r8) 
 ; Statement: if $z1 == 0 goto $i0 = r0.<org.apache.dubbo.common.URLBuilder: int port> 
(assert (not (= (ite var2453 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2988 var2950 var2950-init) ; Statement: $r18 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var2988 "Invalid url, password without username!")) ; Statement: specialinvoke $r18.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Invalid url, password without username!") 

(declare-const var2988!1 var2950)
(declare-const var2203 String)
 ; Statement: throw $r18 
(check-sat)
; {username/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String), var3083_isEmpty/-813097145=([java.lang.String], boolean), password/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String), var3083_isNotEmpty/-1251449450=([java.lang.String], boolean), var2950-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3909=org.apache.dubbo.common.URLBuilder, var849=r0, var2911=$r1, var3083=org.apache.dubbo.common.utils.StringUtils, var3767=$z0, var2256=$r8, var2453=$z1, var2950=java.lang.IllegalArgumentException, var2988=$r18, var2203="Invalid url, password without username!"}
; {org.apache.dubbo.common.URLBuilder=var3909, r0=var849, $r1=var2911, org.apache.dubbo.common.utils.StringUtils=var3083, $z0=var3767, $r8=var2256, $z1=var2453, java.lang.IllegalArgumentException=var2950, $r18=var2988, "Invalid url, password without username!"=var2203}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	$r1 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String username>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $i0 = r0.<org.apache.dubbo.common.URLBuilder: int port>;	$r8 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String password>;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r8);	if $z1 == 0 goto $i0 = r0.<org.apache.dubbo.common.URLBuilder: int port>;	$r18 = new java.lang.IllegalArgumentException;	specialinvoke $r18.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Invalid url, password without username!");	throw $r18
;block_num 3