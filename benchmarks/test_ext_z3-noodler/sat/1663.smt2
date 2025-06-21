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

(declare-sort var3169 0)
(declare-sort var987 0)
(declare-sort var1716 0)
(declare-sort var2639 0)
(declare-sort var387 0)
(declare-sort var3164 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun username/1139202793 (var3169) String)
(declare-fun var987_isEmpty/-813097145 (String) Bool)
(declare-fun port/1139202793 (var3169) Int)
(declare-fun var1716_max/1360571700 (Int Int) Int)
(declare-fun path/1139202793 (var3169) String)
(declare-fun var387-init () var387)
(declare-fun protocol/1139202793 (var3169) String)
(declare-fun password/1139202793 (var3169) String)
(declare-fun host/1139202793 (var3169) String)
(declare-fun parameters/1139202793 (var3169) var3164)
(declare-fun attributes/1139202793 (var3169) var3164)
(declare-fun <init>/1683865000 (var387 String String String String Int String var3164 var3164) void)
(declare-const null-var3169 var3169)
(declare-const null-String String)
(declare-const var2783 var3169) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var2783 null-var3169)))
(define-const var3697 String (username/1139202793 var2783)) ; Statement: $r1 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String username> 
(define-const var1487 Bool (var987_isEmpty/-813097145 var3697)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $i0 = r0.<org.apache.dubbo.common.URLBuilder: int port> 
(assert (= (ite var1487 1 0) 0)) ; Cond: $z0 == 0 
(define-const var422 Int (port/1139202793 var2783)) ; Statement: $i0 = r0.<org.apache.dubbo.common.URLBuilder: int port> 
(define-const var3831 Int (var1716_max/1360571700 var422 0)) ; Statement: $i1 = staticinvoke <java.lang.Math: int max(int,int)>($i0, 0) 
(declare-const var2783!1 var3169)
(assert (not (= var2783!1 null-var3169)))
(assert (= (port/1139202793 var2783!1) var3831)) ; Statement: r0.<org.apache.dubbo.common.URLBuilder: int port> = $i1 
(define-const var336 Int 0) ; Statement: i5 = 0 
(define-const var517 String (path/1139202793 var2783!1)) ; Statement: $r2 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String path> 
 ; Statement: if $r2 == null goto $r19 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (= var517 null-String)) ; Cond: $r2 == null 
(define-const var1488 var387 var387-init) ; Statement: $r19 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var3088 String (protocol/1139202793 var2783!1)) ; Statement: $r11 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String protocol> 
(define-const var1987 String (username/1139202793 var2783!1)) ; Statement: $r12 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String username> 
(define-const var1972 String (password/1139202793 var2783!1)) ; Statement: $r13 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String password> 
(define-const var322 String (host/1139202793 var2783!1)) ; Statement: $r14 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String host> 
(define-const var2923 Int (port/1139202793 var2783!1)) ; Statement: $i6 = r0.<org.apache.dubbo.common.URLBuilder: int port> 
(define-const var904 String (path/1139202793 var2783!1)) ; Statement: $r15 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String path> 
(define-const var3186 var3164 (parameters/1139202793 var2783!1)) ; Statement: $r16 = r0.<org.apache.dubbo.common.URLBuilder: java.util.Map parameters> 
(define-const var1005 var3164 (attributes/1139202793 var2783!1)) ; Statement: $r17 = r0.<org.apache.dubbo.common.URLBuilder: java.util.Map attributes> 
(assert true)
;(assert (<init>/1683865000 var1488 var3088 var1987 var1972 var322 var2923 var904 var3186 var1005)) ; Statement: specialinvoke $r19.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map,java.util.Map)>($r11, $r12, $r13, $r14, $i6, $r15, $r16, $r17) 

(declare-const var1488!1 var387)
(declare-const var3088!1 String)
(declare-const var1987!1 String)
(declare-const var1972!1 String)
(declare-const var322!1 String)
(declare-const var2923!1 Int)
(declare-const var904!1 String)
(declare-const var3186!1 var3164)
(declare-const var1005!1 var3164)
 ; Statement: return $r19 
(check-sat)
; {username/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String), var987_isEmpty/-813097145=([java.lang.String], boolean), port/1139202793=([org.apache.dubbo.common.URLBuilder], int), var1716_max/1360571700=([int, int], int), path/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String), var387-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), protocol/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String), password/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String), host/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String), parameters/1139202793=([org.apache.dubbo.common.URLBuilder], java.util.Map), attributes/1139202793=([org.apache.dubbo.common.URLBuilder], java.util.Map), <init>/1683865000=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map, java.util.Map], void)}
; {var3169=org.apache.dubbo.common.URLBuilder, var2783=r0, var3697=$r1, var987=org.apache.dubbo.common.utils.StringUtils, var1487=$z0, var422=$i0, var1716=java.lang.Math, var3831=$i1, var336=i5, var517=$r2, var2639=null_type, var387=org.apache.dubbo.common.url.component.ServiceConfigURL, var1488=$r19, var3088=$r11, var1987=$r12, var1972=$r13, var322=$r14, var2923=$i6, var904=$r15, var3164=java.util.Map, var3186=$r16, var1005=$r17}
; {org.apache.dubbo.common.URLBuilder=var3169, r0=var2783, $r1=var3697, org.apache.dubbo.common.utils.StringUtils=var987, $z0=var1487, $i0=var422, java.lang.Math=var1716, $i1=var3831, i5=var336, $r2=var517, null_type=var2639, org.apache.dubbo.common.url.component.ServiceConfigURL=var387, $r19=var1488, $r11=var3088, $r12=var1987, $r13=var1972, $r14=var322, $i6=var2923, $r15=var904, java.util.Map=var3164, $r16=var3186, $r17=var1005}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	$r1 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String username>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $i0 = r0.<org.apache.dubbo.common.URLBuilder: int port>;	$i0 = r0.<org.apache.dubbo.common.URLBuilder: int port>;	$i1 = staticinvoke <java.lang.Math: int max(int,int)>($i0, 0);	r0.<org.apache.dubbo.common.URLBuilder: int port> = $i1;	i5 = 0;	$r2 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String path>;	if $r2 == null goto $r19 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r19 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r11 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String protocol>;	$r12 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String username>;	$r13 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String password>;	$r14 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String host>;	$i6 = r0.<org.apache.dubbo.common.URLBuilder: int port>;	$r15 = r0.<org.apache.dubbo.common.URLBuilder: java.lang.String path>;	$r16 = r0.<org.apache.dubbo.common.URLBuilder: java.util.Map parameters>;	$r17 = r0.<org.apache.dubbo.common.URLBuilder: java.util.Map attributes>;	specialinvoke $r19.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map,java.util.Map)>($r11, $r12, $r13, $r14, $i6, $r15, $r16, $r17);	return $r19
;block_num 3